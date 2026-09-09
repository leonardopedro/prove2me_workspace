import Mathlib

/-!
# Chapter U — Unitary inference / unfer

Formalization of the self-contained mathematical content of Chapter U of the
`unfer` source material (see `FORMALIZATION_ROADMAP.md` §U, work package N8),
to be merged into `book.tex`.  Deliverables:

* **U.1** (headline): the Born-rule *conditioning by projection* of a
  wave-function equals the classical conditional measure
  `ProbabilityTheory.cond` — quantum conditioning (wave-function collapse onto
  an event) and Bayesian conditioning are the same operation.
* **U.3**: the Fock-space exponential property `Sym(M × N) ≅ Sym M ⊗ Sym N`.
* **U.4**: the measure-theoretic wrapper around the (external) fact that
  stochastic trajectories are a.s. nowhere differentiable.
* **U.5**: independent components ⇒ portfolio risk falls like `1/√n`.

U.2 (sphere→Gaussian / Gegenbauer→Hermite) is already `sorry`-free in
`BookProof/PhysHSGaussian.lean`; it is a cross-reference only, no new code here.
-/

open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

namespace BookProof.ChapterU

/-! ## U.1 — Born-rule conditioning is Bayesian updating by projection -/

variable {X : Type*} [MeasurableSpace X]

/-- The Born probability measure `|Ψ|²·μ` of a wave-function. -/
noncomputable def bornMeasure (Ψ : X → ℂ) (μ : Measure X) : Measure X :=
  μ.withDensity (fun x => ENNReal.ofReal (‖Ψ x‖ ^ 2))

/-
The Born measure of a normalized `L²` wave-function is a probability
measure (Chapter B `born_backward`, re-packaged).
-/
theorem bornMeasure_isProbability (Ψ : X → ℂ) (μ : Measure X)
    (hΨ : MemLp Ψ 2 μ) (hnorm : ∫ x, ‖Ψ x‖ ^ 2 ∂μ = 1) :
    IsProbabilityMeasure (bornMeasure Ψ μ) := by
  constructor;
  unfold bornMeasure;
  rw [ MeasureTheory.integral_eq_lintegral_of_nonneg_ae ] at hnorm;
  · rw [ ENNReal.toReal_eq_one_iff ] at hnorm ; aesop;
  · exact Filter.Eventually.of_forall fun x => sq_nonneg _;
  · simpa using hΨ.1.norm.aemeasurable.pow_const 2 |> fun h => h.aestronglyMeasurable

/-- Conditioning by projection: zero the non-matching components, renormalize. -/
noncomputable def conditionedState (Ψ : X → ℂ) (μ : Measure X) (E : Set X) : X → ℂ :=
  fun x => (Real.sqrt ((bornMeasure Ψ μ) E).toReal)⁻¹ • E.indicator Ψ x

/-- **U.1 headline — the quantum⇄Bayes bridge.** The Born measure of the
projected-and-renormalized state is exactly the classical conditional measure
(`ProbabilityTheory.cond`, `μ[|E]`): wave-function collapse onto an event and
Bayesian conditioning are the same operation.

§0 S7 / `../unfer`: this is the Born layer implemented by the `prob_kernel`
crate's `Session.condition`; the present theorem is its measure-theoretic
correctness statement. -/
theorem born_conditioning (Ψ : X → ℂ) (μ : Measure X) (E : Set X)
    (hE : MeasurableSet E) (hpos : bornMeasure Ψ μ E ≠ 0)
    (_hfin : bornMeasure Ψ μ E ≠ ∞) :
    bornMeasure (conditionedState Ψ μ E) μ = (bornMeasure Ψ μ)[|E] := by
  ext s hs;
  simp only [bornMeasure, norm_nonneg, ENNReal.ofReal_pow, ofReal_norm, withDensity_apply,
      ProbabilityTheory.cond_apply, MeasurableSet.inter, hs, hE];
  simp only [conditionedState, Complex.real_smul, Complex.ofReal_inv, enorm_mul];
  simp only [mul_pow, hs, ← lintegral_indicator, hE, MeasurableSet.inter];
  have h_const : (∫⁻ x, s.indicator (fun x => ‖(↑√((bornMeasure Ψ μ) E).toReal)⁻¹‖ₑ ^ 2 *
      ‖E.indicator Ψ x‖ₑ ^ 2) x ∂μ) = ‖(↑√((bornMeasure Ψ μ) E).toReal)⁻¹‖ₑ ^ 2 * ∫⁻ x, s.indicator
          (fun x => ‖E.indicator Ψ x‖ₑ ^ 2) x ∂μ := by
    rw [ ← MeasureTheory.lintegral_const_mul' ];
    · congr with x ; by_cases hx : x ∈ s <;> simp [ hx ];
    · finiteness
  convert h_const using 2;
  · norm_num [ ENorm.enorm ];
  · rw [ ← ENNReal.toReal_eq_toReal_iff' ] <;> norm_num;
    · unfold bornMeasure; aesop;
    · unfold bornMeasure at * ; aesop;
  · congr with x ; by_cases hx : x ∈ E <;> by_cases hx' : x ∈ s <;> simp [ hx, hx' ]

/-! ## U.3 — Fock-space layer: the exponential property `Sym(M ⊕ N) ≅ Sym M ⊗ Sym N` -/

section Fock

variable (R M N : Type*) [CommRing R] [AddCommGroup M] [Module R M]
  [AddCommGroup N] [Module R N]

/-- Forward map of the exponential property: `Sym(M × N) → Sym M ⊗ Sym N`,
sending a generator `(m, n)` to `ι m ⊗ 1 + 1 ⊗ ι n`. -/
noncomputable def prodToTensor :
    SymmetricAlgebra R (M × N) →ₐ[R] (SymmetricAlgebra R M ⊗[R] SymmetricAlgebra R N) :=
  SymmetricAlgebra.lift
    ((Algebra.TensorProduct.includeLeft.toLinearMap ∘ₗ SymmetricAlgebra.ι R M)
        ∘ₗ (LinearMap.fst R M N)
      + (Algebra.TensorProduct.includeRight.toLinearMap ∘ₗ SymmetricAlgebra.ι R N)
        ∘ₗ (LinearMap.snd R M N))

/-- Backward map of the exponential property: `Sym M ⊗ Sym N → Sym(M × N)`. -/
noncomputable def tensorToProd :
    (SymmetricAlgebra R M ⊗[R] SymmetricAlgebra R N) →ₐ[R] SymmetricAlgebra R (M × N) :=
  Algebra.TensorProduct.lift
    (SymmetricAlgebra.lift (SymmetricAlgebra.ι R (M × N) ∘ₗ LinearMap.inl R M N))
    (SymmetricAlgebra.lift (SymmetricAlgebra.ι R (M × N) ∘ₗ LinearMap.inr R M N))
    (fun _ _ => Commute.all _ _)

theorem tensorToProd_comp_prodToTensor :
    (tensorToProd R M N).comp (prodToTensor R M N) = AlgHom.id R _ := by
  ext x; all_goals simp [ tensorToProd, prodToTensor ]

theorem prodToTensor_comp_tensorToProd :
    (prodToTensor R M N).comp (tensorToProd R M N) = AlgHom.id R _ := by
  ext x; all_goals simp [ prodToTensor, tensorToProd ]

/-- **U.3 — the exponential property of the (bosonic) Fock functor.**
`Sym(M × N) ≅ Sym M ⊗ Sym N` as `R`-algebras: the tensor product of two Fock
spaces is again a Fock space (so no infinite-dimensional tensor product is
needed).

§0 S7 / `../unfer`: this exponential law is the implemented Fock layer of the
`nested_fock_algebra` crate (the bosonic symmetric-algebra model reused by the
CCR field package `ChapterF1`). -/
noncomputable def prodEquiv :
    SymmetricAlgebra R (M × N) ≃ₐ[R] (SymmetricAlgebra R M ⊗[R] SymmetricAlgebra R N) :=
  AlgEquiv.ofAlgHom (prodToTensor R M N) (tensorToProd R M N)
    (prodToTensor_comp_tensorToProd R M N) (tensorToProd_comp_prodToTensor R M N)

end Fock

/-! ## U.4 — Non-differentiability of stochastic trajectories (`EXTERNAL` + wrapper) -/

/-
**U.4 wrapper.** Given the (external, cited: Paley–Wiener–Zygmund 1933,
Bertoin 1994) fact that the paths are a.s. nowhere differentiable, the event
that *some* time point is a point of differentiability is null — i.e. its
complement carries full probability.  Fixing the *statement* precisely scopes
the external hypothesis; Mathlib v4.28.0 has no Brownian motion.
-/
theorem no_differentiable_trajectory {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    [IsProbabilityMeasure P] (path : Ω → ℝ → ℝ)
    (hext : ∀ᵐ ω ∂P, ∀ t, ¬ DifferentiableAt ℝ (path ω) t) :
    P {ω | ∃ t, DifferentiableAt ℝ (path ω) t}ᶜ = 1 := by
  rw [ MeasureTheory.measure_congr, IsProbabilityMeasure.measure_univ ];
  simp_all [ MeasureTheory.ae_iff ]

/-
The `P(differentiable) = 0` corollary of `no_differentiable_trajectory`.
-/
theorem differentiable_trajectory_null {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    [IsProbabilityMeasure P] (path : Ω → ℝ → ℝ)
    (hext : ∀ᵐ ω ∂P, ∀ t, ¬ DifferentiableAt ℝ (path ω) t) :
    P {ω | ∃ t, DifferentiableAt ℝ (path ω) t} = 0 := by
  refine MeasureTheory.measure_mono_null (fun ω hω => ?_) hext
  aesop

/-! ## U.5 — Independent components: portfolio risk falls like `1/√n` -/

variable {Ω : Type*} [MeasurableSpace Ω]

/-
**U.5.** For `n` independent components each of variance `σ²`, the variance
of the average `(∑ Xᵢ)/n` is `σ²/n` — the Central-Limit `1/√n` reduction of
aggregate portfolio risk (no CLT needed; only additivity of variance).
-/
theorem portfolio_risk_inv_sqrt {n : ℕ} (hn : 0 < n) (X : Fin n → Ω → ℝ) (σ : ℝ)
    (P : Measure Ω) [IsProbabilityMeasure P]
    (hindep : ProbabilityTheory.iIndepFun X P)
    (hmem : ∀ i, MemLp (X i) 2 P) (hvar : ∀ i, ProbabilityTheory.variance (X i) P = σ ^ 2) :
    ProbabilityTheory.variance (fun ω => (∑ i, X i ω) / n) P = σ ^ 2 / n := by
  have h_var_sum : (ProbabilityTheory.variance (fun ω => ∑ i, X i ω) P) = ∑ i,
      (ProbabilityTheory.variance (X i) P) := by
    convert ProbabilityTheory.IndepFun.variance_sum ( fun i _ => hmem i ) _;
    · simp [ Finset.sum_apply ];
    · intro i _ j _ hij; exact hindep.indepFun hij;
  simp_all [ div_eq_inv_mul, ProbabilityTheory.variance_const_mul ];
  simp [ sq, mul_assoc, hn.ne' ]

/-
Standard-deviation form of `portfolio_risk_inv_sqrt`: the aggregate
standard deviation is `σ/√n`.
-/
theorem portfolio_std_inv_sqrt {n : ℕ} (hn : 0 < n) (X : Fin n → Ω → ℝ) (σ : ℝ)
    (hσ : 0 ≤ σ) (P : Measure Ω) [IsProbabilityMeasure P]
    (hindep : ProbabilityTheory.iIndepFun X P)
    (hmem : ∀ i, MemLp (X i) 2 P) (hvar : ∀ i, ProbabilityTheory.variance (X i) P = σ ^ 2) :
    Real.sqrt (ProbabilityTheory.variance (fun ω => (∑ i, X i ω) / n) P) = σ / Real.sqrt n := by
  convert congr_arg Real.sqrt ( portfolio_risk_inv_sqrt hn X σ P hindep hmem hvar ) using 1;
  rw [ Real.sqrt_div ( sq_nonneg _ ), Real.sqrt_sq hσ ]

end BookProof.ChapterU
