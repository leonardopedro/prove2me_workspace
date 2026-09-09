import Mathlib
import BookProof.ChapterHyperbolicQuadraticEsa

/-!
# The translated, modulated Gauss–polynomial core of `L²(ℝᵈ)`

`BookProof.ChapterHermiteProductCore` builds the Gauss–polynomial (product Hermite) core
`polyGaussCore = { p · e^{-‖x‖²/4} }` of `L²(ℝᵈ)` and proves it dense, and
`BookProof.ChapterHyperbolicQuadraticEsa` uses it to diagonalize the diagonal quadratic
Hamiltonians `H_c = ∑ᵢ cᵢ(πᵢ² + xᵢ²/4)`.

This module builds the **phase-space translate** of that core: for a translation vector
`a ∈ ℝᵈ` and a wave vector `k ∈ ℝᵈ`,

`D_{a,k} = { x ↦ p(x − a) · e^{-‖x−a‖²/4} · e^{i⟨k,x⟩} : p ∈ ℂ[X₀,…,X_{d-1}] }`.

This is the image of `polyGaussCore` under the Weyl (phase-space translation) unitary
`f ↦ e^{i⟨k,x⟩} f(x − a)`, and it is the natural core for a quadratic Hamiltonian that has
been *completed to a square*: it is the Hermite core recentred at the classical
equilibrium `x = a` and boosted to the classical momentum `k`.

## What is proved

* `pgFunT`, `memLp_pgFunT`, `pgLpT`, `pgMapT`, `pgMapT_injective` — the translated,
  modulated Gauss–polynomial functions are square integrable and depend injectively on the
  polynomial;
* `inner_pgLpT` — the map is **isometric**: `⟪pgLpT a k p, pgLpT a k q⟫ = ⟪pgLp p, pgLp q⟫`
  (translation invariance of Lebesgue measure and `|e^{i⟨k,x⟩}| = 1`);
* `polyGaussCoreT`, `polyGaussCoreT_dense` — the resulting core is dense in `L²(ℝᵈ)`;
* `hermiteTLp`, `orthonormal_hermiteTLp`, `span_hermiteTLp`, `hermiteTLp_total` — the
  translated, modulated product Hermite functions are an orthonormal family spanning the
  core, and total in `L²(ℝᵈ)`;
* `coreEquivT`, `coreOpT` — the core coordinatized by polynomials, and operators on it
  given by operators on the polynomial coordinates;
* `mulXTPoly`, `momTPoly`, `pgFunT_mulXTPoly`, `pgFunT_momTPoly` — **the canonical pair in
  the translated frame**: on `D_{a,k}` multiplication by `xᵢ` is `Xᵢ + aᵢ` and the momentum
  `πᵢ = −i∂/∂xᵢ` is `momPolyᵢ + kᵢ` in the polynomial coordinates, the second identity
  being an honest statement about Mathlib's `deriv` along the `i`-th coordinate line.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ShiftedHermiteCore

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

/-! ## The unimodular phase -/

/-- The linear phase argument `⟨k, x⟩ = ∑ᵢ kᵢxᵢ`. -/
def phaseArg (k x : Vd d) : ℝ := ∑ i, k i * x i

/-- The unimodular phase `e^{i⟨k,x⟩}`. -/
def phaseFun (k x : Vd d) : ℂ := Complex.exp (Complex.I * ((phaseArg k x : ℝ) : ℂ))

theorem norm_phaseFun (k x : Vd d) : ‖phaseFun k x‖ = 1 := by
  rw [phaseFun, Complex.norm_exp]
  simp [Complex.mul_re]

theorem phaseFun_ne_zero (k x : Vd d) : phaseFun k x ≠ 0 := Complex.exp_ne_zero _

theorem continuous_phaseFun (k : Vd d) : Continuous (phaseFun k : Vd d → ℂ) := by
  refine Complex.continuous_exp.comp (continuous_const.mul ?_)
  exact Complex.continuous_ofReal.comp (by unfold phaseArg; fun_prop)

/-- The phase is multiplied by `e^{i⟨k,y⟩}` under a translation of the argument. -/
theorem phaseFun_add (k x y : Vd d) : phaseFun k (x + y) = phaseFun k x * phaseFun k y := by
  rw [phaseFun, phaseFun, phaseFun, ← Complex.exp_add]
  congr 1
  have : phaseArg k (x + y) = phaseArg k x + phaseArg k y := by
    simp only [phaseArg, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => by simp [mul_add]
  rw [this]
  push_cast
  ring

theorem conj_mul_phaseFun (k x : Vd d) :
    (starRingEnd ℂ) (phaseFun k x) * phaseFun k x = 1 := by
  have hz : (starRingEnd ℂ) (Complex.I * ((phaseArg k x : ℝ) : ℂ))
      = -(Complex.I * ((phaseArg k x : ℝ) : ℂ)) := by
    simp [Complex.conj_I]
  rw [phaseFun, ← Complex.exp_conj, hz, ← Complex.exp_add]
  simp

/-! ## The translated, modulated Gauss–polynomial functions -/

/-- `pgFunT a k p x = p(x − a) · e^{-‖x−a‖²/4} · e^{i⟨k,x⟩}`. -/
def pgFunT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) : ℂ :=
  pgFun p (x - a) * phaseFun k x

theorem continuous_pgFunT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    Continuous (pgFunT a k p) :=
  ((continuous_pgFun p).comp (continuous_id.sub continuous_const)).mul (continuous_phaseFun k)

theorem norm_pgFunT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    ‖pgFunT a k p x‖ = ‖pgFun p (x - a)‖ := by
  rw [pgFunT, norm_mul, norm_phaseFun, mul_one]

theorem pgFunT_add (a k : Vd d) (p q : MvPolynomial (Fin d) ℂ) :
    pgFunT a k (p + q) = pgFunT a k p + pgFunT a k q := by
  funext x; simp [pgFunT, HermiteProductCore.pgFun_add, add_mul]

theorem pgFunT_smul (a k : Vd d) (c : ℂ) (p : MvPolynomial (Fin d) ℂ) :
    pgFunT a k (c • p) = c • pgFunT a k p := by
  funext x; simp [pgFunT, HermiteProductCore.pgFun_smul, mul_assoc]

/-- Translation invariance of the `MemLp` condition. -/
theorem memLp_comp_sub {f : Vd d → ℂ} (hf : MemLp f 2 (volume : Measure (Vd d))) (a : Vd d) :
    MemLp (fun x : Vd d => f (x - a)) 2 (volume : Measure (Vd d)) :=
  hf.comp_measurePreserving (measurePreserving_sub_right (volume : Measure (Vd d)) a)

theorem memLp_pgFunT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    MemLp (pgFunT a k p) 2 (volume : Measure (Vd d)) := by
  refine (memLp_comp_sub (memLp_pgFun p) a).mono
    (continuous_pgFunT a k p).aestronglyMeasurable
    (Filter.Eventually.of_forall fun x => ?_)
  rw [norm_pgFunT]

/-- The element of `L²(ℝᵈ)` given by the translated, modulated Gauss–polynomial. -/
def pgLpT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) : L2d d := (memLp_pgFunT a k p).toLp _

theorem pgLpT_coeFn (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    (pgLpT a k p : Vd d → ℂ) =ᵐ[volume] pgFunT a k p := (memLp_pgFunT a k p).coeFn_toLp

/-- The translated, modulated Gauss–polynomial map `ℂ[X₀,…,X_{d-1}] →ₗ[ℂ] L²(ℝᵈ)`. -/
def pgMapT (a k : Vd d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] L2d d where
  toFun := pgLpT a k
  map_add' p q := by
    simp only [pgLpT]
    rw [← MemLp.toLp_add (memLp_pgFunT a k p) (memLp_pgFunT a k q)]
    congr 1
    exact pgFunT_add a k p q
  map_smul' c p := by
    simp only [pgLpT, RingHom.id_apply]
    rw [← MemLp.toLp_const_smul c (memLp_pgFunT a k p)]
    congr 1
    exact pgFunT_smul a k c p

@[simp] theorem pgMapT_apply (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    pgMapT a k p = pgLpT a k p := rfl

/-! ## The map is an isometry of the core -/

/-- **The translated, modulated map preserves inner products.**  Translation invariance of
Lebesgue measure and `|e^{i⟨k,x⟩}| = 1`. -/
theorem inner_pgLpT (a k : Vd d) (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLpT a k p) (pgLpT a k q) : ℂ) = inner ℂ (pgLp p) (pgLp q) := by
  have hleft : (inner ℂ (pgLpT a k p) (pgLpT a k q) : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFunT a k p x) * pgFunT a k q x := by
    rw [L2.inner_def]
    refine integral_congr_ae ?_
    filter_upwards [pgLpT_coeFn a k p, pgLpT_coeFn a k q] with x hx hy
    rw [hx, hy, RCLike.inner_apply, mul_comm]
  have hright : (inner ℂ (pgLp p) (pgLp q) : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFun p x) * pgFun q x := by
    rw [L2.inner_def]
    refine integral_congr_ae ?_
    filter_upwards [pgLp_coeFn p, pgLp_coeFn q] with x hx hy
    rw [hx, hy, RCLike.inner_apply, mul_comm]
  rw [hleft, hright]
  have hpt : ∀ x : Vd d, (starRingEnd ℂ) (pgFunT a k p x) * pgFunT a k q x
      = ((fun y : Vd d => (starRingEnd ℂ) (pgFun p y) * pgFun q y) (x - a)) := by
    intro x
    simp only [pgFunT, map_mul]
    calc (starRingEnd ℂ) (pgFun p (x - a)) * (starRingEnd ℂ) (phaseFun k x)
          * (pgFun q (x - a) * phaseFun k x)
        = ((starRingEnd ℂ) (phaseFun k x) * phaseFun k x)
          * ((starRingEnd ℂ) (pgFun p (x - a)) * pgFun q (x - a)) := by ring
      _ = (starRingEnd ℂ) (pgFun p (x - a)) * pgFun q (x - a) := by
          rw [conj_mul_phaseFun, one_mul]
  simp_rw [hpt]
  exact integral_sub_right_eq_self (fun y : Vd d => (starRingEnd ℂ) (pgFun p y) * pgFun q y) a

theorem norm_pgLpT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    ‖pgLpT a k p‖ = ‖pgLp p‖ := by
  have h := inner_pgLpT a k p p
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at h
  have h2 : (‖pgLpT a k p‖ : ℝ) ^ 2 = (‖pgLp p‖ : ℝ) ^ 2 := by exact_mod_cast h
  have h3 := congrArg Real.sqrt h2
  rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (norm_nonneg _)] at h3

theorem pgMapT_injective (a k : Vd d) : Function.Injective (pgMapT a k) := by
  rw [injective_iff_map_eq_zero]
  intro p hp
  have h0 : ‖pgLp p‖ = 0 := by
    rw [← norm_pgLpT a k p]
    simp only [pgMapT_apply] at hp
    rw [hp, norm_zero]
  have hz : pgMap (d := d) p = 0 := by
    simpa [HermiteProductCore.pgMap_apply] using norm_eq_zero.mp h0
  exact (injective_iff_map_eq_zero _).mp HermiteProductCore.pgMap_injective p hz

/-- **The translated, modulated Gauss–polynomial core** `D_{a,k}` of `L²(ℝᵈ)`. -/
def polyGaussCoreT (a k : Vd d) : Submodule ℂ (L2d d) := LinearMap.range (pgMapT a k)

theorem pgLpT_mem_coreT (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    pgLpT a k p ∈ polyGaussCoreT a k := ⟨p, rfl⟩

theorem pgLpT_smul (a k : Vd d) (c : ℂ) (p : MvPolynomial (Fin d) ℂ) :
    pgLpT a k (c • p) = c • pgLpT a k p := (pgMapT a k).map_smul c p

/-! ## The core is dense -/

theorem inner_pgLpT_left (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) (u : L2d d) :
    (inner ℂ (pgLpT a k p) u : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFunT a k p x) * (u : Vd d → ℂ) x := by
  rw [L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [pgLpT_coeFn a k p] with x hx
  rw [hx, RCLike.inner_apply, mul_comm]

/-- **The translated, modulated core is dense in `L²(ℝᵈ)`.**  A vector orthogonal to it is,
after the substitution `x = y + a`, orthogonal to every Gauss–polynomial, so it vanishes by
the multidimensional Fourier/moment argument. -/
theorem polyGaussCoreT_dense (a k : Vd d) :
    Dense ((polyGaussCoreT a k : Submodule ℂ (L2d d)) : Set (L2d d)) := by
  rw [Submodule.dense_iff_topologicalClosure_eq_top, Submodule.topologicalClosure_eq_top_iff,
    Submodule.eq_bot_iff]
  intro u hu
  have hu2 : MemLp (u : Vd d → ℂ) 2 (volume : Measure (Vd d)) := Lp.memLp u
  have hshift : MemLp (fun y : Vd d => (u : Vd d → ℂ) (y + a)) 2 (volume : Measure (Vd d)) :=
    hu2.comp_measurePreserving (measurePreserving_add_right (volume : Measure (Vd d)) a)
  set w : Vd d → ℂ :=
    fun y => (starRingEnd ℂ) (phaseFun k (y + a)) * (u : Vd d → ℂ) (y + a) with hwdef
  have hwnorm : ∀ y : Vd d, ‖w y‖ = ‖(u : Vd d → ℂ) (y + a)‖ := by
    intro y
    rw [hwdef]
    simp [norm_phaseFun]
  have hwLp : MemLp w 2 (volume : Measure (Vd d)) := by
    refine hshift.mono ?_ (Filter.Eventually.of_forall fun y => (hwnorm y).le)
    have hphase : Continuous fun y : Vd d => (starRingEnd ℂ) (phaseFun k (y + a)) :=
      Complex.continuous_conj.comp
        ((continuous_phaseFun k).comp (continuous_id.add continuous_const))
    exact hphase.aestronglyMeasurable.mul hshift.1
  have hmon : ∀ α : Fin d →₀ ℕ, ∫ y : Vd d, pgFun (monomial α (1 : ℂ)) y * w y = 0 := by
    intro α
    have h0 : (inner ℂ (pgLpT a k (monomial α (1 : ℂ))) u : ℂ) = 0 :=
      hu _ (pgLpT_mem_coreT a k _)
    rw [inner_pgLpT_left] at h0
    have hsub : ∫ x : Vd d,
          (starRingEnd ℂ) (pgFunT a k (monomial α (1 : ℂ)) x) * (u : Vd d → ℂ) x
        = ∫ y : Vd d,
          (starRingEnd ℂ) (pgFunT a k (monomial α (1 : ℂ)) (y + a))
            * (u : Vd d → ℂ) (y + a) :=
      (integral_add_right_eq_self
        (fun x : Vd d =>
          (starRingEnd ℂ) (pgFunT a k (monomial α (1 : ℂ)) x) * (u : Vd d → ℂ) x) a).symm
    rw [hsub] at h0
    rw [← h0]
    refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
    simp only [pgFunT, hwdef, add_sub_cancel_right, map_mul]
    rw [conj_pgFun_monomial_one]
    ring
  have hmom : ∀ p : MvPolynomial (Fin d) ℂ, ∫ y : Vd d, pgFun p y * w y = 0 := by
    intro p
    have hsum : p = ∑ v ∈ p.support, (monomial v) (MvPolynomial.coeff v p) :=
      (MvPolynomial.support_sum_monomial_coeff p).symm
    have hpt : ∀ y : Vd d, pgFun p y * w y
        = ∑ v ∈ p.support, MvPolynomial.coeff v p * (pgFun (monomial v (1 : ℂ)) y * w y) := by
      intro y
      rw [pgFun]
      nth_rewrite 1 [hsum]
      rw [map_sum, Finset.sum_mul, Finset.sum_mul]
      refine Finset.sum_congr rfl fun v _ => ?_
      rw [pgFun, MvPolynomial.eval_monomial, MvPolynomial.eval_monomial]
      ring
    simp_rw [hpt]
    rw [integral_finset_sum _ (fun v _ =>
      ((integrable_mul_of_memLp_two (memLp_pgFun (monomial v (1 : ℂ))) hwLp)).const_mul _)]
    simp [integral_const_mul, hmon]
  have hzero := ae_eq_zero_of_moments hwLp hmom
  have hua : ∀ᵐ y : Vd d, (u : Vd d → ℂ) (y + a) = 0 := by
    filter_upwards [hzero] with y hy
    rcases mul_eq_zero.mp hy with h | h
    · exact absurd ((starRingEnd ℂ).injective (by simpa using h)) (phaseFun_ne_zero k (y + a))
    · exact h
  have hinner : (inner ℂ u u : ℂ) = 0 := by
    rw [L2.inner_def]
    rw [← integral_add_right_eq_self
      (fun x : Vd d => (inner ℂ ((u : Vd d → ℂ) x) ((u : Vd d → ℂ) x) : ℂ)) a]
    refine integral_eq_zero_of_ae ?_
    filter_upwards [hua] with y hy
    simp [hy]
  exact inner_self_eq_zero.mp hinner

/-! ## The translated, modulated product Hermite functions -/

/-- The translated, modulated product Hermite function
`ψ_α(x − a) e^{i⟨k,x⟩}`, normalized in `L²`. -/
def hermiteTLp (a k : Vd d) (α : Fin d →₀ ℕ) : L2d d :=
  ((hermiteMvNorm α : ℝ) : ℂ)⁻¹ • pgLpT a k (hermiteMv α)

theorem inner_hermiteTLp (a k : Vd d) (α β : Fin d →₀ ℕ) :
    (inner ℂ (hermiteTLp a k α) (hermiteTLp a k β) : ℂ)
      = (inner ℂ (hermiteMvLp (d := d) α) (hermiteMvLp (d := d) β) : ℂ) := by
  rw [hermiteTLp, hermiteTLp, hermiteMvLp, hermiteMvLp, inner_smul_left, inner_smul_right,
    inner_smul_left, inner_smul_right, inner_pgLpT]

theorem orthonormal_hermiteTLp (a k : Vd d) : Orthonormal ℂ (hermiteTLp (d := d) a k) := by
  rw [orthonormal_iff_ite]
  intro α β
  rw [inner_hermiteTLp]
  exact orthonormal_iff_ite.mp orthonormal_hermiteMvLp α β

theorem hermiteTLp_mem_coreT (a k : Vd d) (α : Fin d →₀ ℕ) :
    hermiteTLp a k α ∈ polyGaussCoreT a k :=
  Submodule.smul_mem _ _ (pgLpT_mem_coreT a k _)

/-- The translated, modulated Hermite functions span the translated, modulated core. -/
theorem span_hermiteTLp (a k : Vd d) :
    Submodule.span ℂ (Set.range (hermiteTLp (d := d) a k)) = polyGaussCoreT a k := by
  have hbase : Submodule.span ℂ
      (Set.range fun α : Fin d →₀ ℕ => pgLpT a k (hermiteMv α)) = polyGaussCoreT a k := by
    have hrange : (Set.range fun α : Fin d →₀ ℕ => pgLpT a k (hermiteMv α))
        = (pgMapT a k) '' (Set.range (hermiteMv (d := d))) := by
      rw [← Set.range_comp]
      rfl
    rw [hrange, ← Submodule.map_span, span_hermiteMv, Submodule.map_top, polyGaussCoreT]
  rw [← hbase]
  refine le_antisymm ?_ ?_
  · rw [Submodule.span_le]
    rintro _ ⟨α, rfl⟩
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨α, rfl⟩)
  · rw [Submodule.span_le]
    rintro _ ⟨α, rfl⟩
    change pgLpT a k (hermiteMv α) ∈ Submodule.span ℂ (Set.range (hermiteTLp (d := d) a k))
    have h : pgLpT a k (hermiteMv α) = ((hermiteMvNorm α : ℝ) : ℂ) • hermiteTLp a k α := by
      rw [hermiteTLp, smul_smul, mul_inv_cancel₀ (hermiteMvNorm_ne_zero α), one_smul]
    rw [h]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨α, rfl⟩)

/-- A vector orthogonal to the whole translated core vanishes. -/
theorem eq_zero_of_inner_coreT (a k : Vd d) (v : L2d d)
    (h : ∀ z ∈ polyGaussCoreT a k, (inner ℂ z v : ℂ) = 0) : v = 0 := by
  have hclosed : IsClosed {z : L2d d | (inner ℂ z v : ℂ) = 0} := by
    have hcont : Continuous fun z : L2d d => (inner ℂ z v : ℂ) := by fun_prop
    exact isClosed_eq hcont continuous_const
  have hsub : (Set.univ : Set (L2d d)) ⊆ {z : L2d d | (inner ℂ z v : ℂ) = 0} := by
    rw [← (polyGaussCoreT_dense a k).closure_eq]
    exact hclosed.closure_subset_iff.mpr h
  exact inner_self_eq_zero.mp (hsub (Set.mem_univ v))

/-- **The translated, modulated Hermite functions are total.** -/
theorem hermiteTLp_total (a k : Vd d) (v : L2d d)
    (h : ∀ α, (inner ℂ (hermiteTLp (d := d) a k α) v : ℂ) = 0) : v = 0 := by
  refine eq_zero_of_inner_coreT a k v fun z hz => ?_
  rw [← span_hermiteTLp a k] at hz
  induction hz using Submodule.span_induction with
  | mem z hz => obtain ⟨α, rfl⟩ := hz; exact h α
  | zero => simp
  | add z z' _ _ ihz ihz' => rw [inner_add_left, ihz, ihz']; ring
  | smul r z _ ih => rw [inner_smul_left, ih]; ring

/-! ## The core coordinatized by polynomials -/

/-- The translated, modulated core, coordinatized by polynomials. -/
def coreEquivT (a k : Vd d) : MvPolynomial (Fin d) ℂ ≃ₗ[ℂ] (polyGaussCoreT a k) :=
  LinearEquiv.ofInjective (pgMapT a k) (pgMapT_injective a k)

theorem coreEquivT_coe (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    ((coreEquivT a k p : polyGaussCoreT a k) : L2d d) = pgLpT a k p := rfl

/-- An operator on the translated core, given by an operator on the polynomial
coordinates. -/
def coreOpT (a k : Vd d) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    (polyGaussCoreT a k) →ₗ[ℂ] (polyGaussCoreT a k) :=
  (coreEquivT a k).toLinearMap ∘ₗ T ∘ₗ (coreEquivT a k).symm.toLinearMap

theorem coreOpT_coreEquivT (a k : Vd d) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) : coreOpT a k T (coreEquivT a k p) = coreEquivT a k (T p) := by
  simp [coreOpT]

theorem coreOpT_coe (a k : Vd d) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) :
    ((coreOpT a k T (coreEquivT a k p) : polyGaussCoreT a k) : L2d d) = pgLpT a k (T p) := by
  rw [coreOpT_coreEquivT, coreEquivT_coe]

/-! ## The canonical pair in the translated, modulated frame -/

theorem pgFunT_apply_add (a k : Vd d) (p q : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (p + q) x = pgFunT a k p x + pgFunT a k q x :=
  congrFun (pgFunT_add a k p q) x

theorem pgFunT_apply_smul (a k : Vd d) (c : ℂ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (c • p) x = c * pgFunT a k p x :=
  congrFun (pgFunT_smul a k c p) x

/-- The phase along the `i`-th coordinate line. -/
theorem phaseArg_sec (k x : Vd d) (i : Fin d) (t : ℝ) :
    phaseArg k (sec i x t) = phaseArg k x + k i * (t - x i) := by
  classical
  have hterm : ∀ j : Fin d, k j * (sec i x t) j
      = k j * x j + (if j = i then k i * (t - x i) else 0) := by
    intro j
    rw [sec_apply]
    by_cases hj : j = i
    · subst hj; simp; ring
    · simp [hj]
  rw [phaseArg, phaseArg, Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib]
  simp

theorem phaseFun_sec (k x : Vd d) (i : Fin d) (t : ℝ) :
    phaseFun k (sec i x t)
      = phaseFun k x * Complex.exp (Complex.I * (((k i * (t - x i) : ℝ)) : ℂ)) := by
  rw [phaseFun, phaseFun, phaseArg_sec, ← Complex.exp_add]
  congr 1
  push_cast
  ring

/-- The derivative of the phase along the `i`-th coordinate line. -/
theorem hasDerivAt_phaseFun_sec (k x : Vd d) (i : Fin d) :
    HasDerivAt (fun t : ℝ => phaseFun k (sec i x t))
      (phaseFun k x * (Complex.I * ((k i : ℝ) : ℂ))) (x i) := by
  have hlin : HasDerivAt
      (fun z : ℂ => Complex.I * (((k i : ℝ) : ℂ) * (z - ((x i : ℝ) : ℂ))))
      (Complex.I * ((k i : ℝ) : ℂ)) (((x i : ℝ)) : ℂ) := by
    simpa using
      ((((hasDerivAt_id (((x i : ℝ)) : ℂ)).sub_const (((x i : ℝ)) : ℂ)).const_mul
        (((k i : ℝ) : ℂ))).const_mul Complex.I)
  have hE : HasDerivAt
      (fun z : ℂ => Complex.exp (Complex.I * (((k i : ℝ) : ℂ) * (z - ((x i : ℝ) : ℂ)))))
      (Complex.I * ((k i : ℝ) : ℂ)) (((x i : ℝ)) : ℂ) := by
    simpa using hlin.cexp
  have hR := hE.comp_ofReal (z := x i)
  have hfun : (fun t : ℝ =>
        Complex.exp (Complex.I * (((k i : ℝ) : ℂ) * (((t : ℝ) : ℂ) - ((x i : ℝ) : ℂ)))))
      = fun t : ℝ => Complex.exp (Complex.I * (((k i * (t - x i) : ℝ)) : ℂ)) := by
    funext t
    congr 2
    push_cast
    ring
  rw [hfun] at hR
  have hmul := hR.const_mul (phaseFun k x)
  have hfun2 : (fun t : ℝ =>
        phaseFun k x * Complex.exp (Complex.I * (((k i * (t - x i) : ℝ)) : ℂ)))
      = fun t : ℝ => phaseFun k (sec i x t) := by
    funext t
    rw [phaseFun_sec]
  rwa [hfun2] at hmul

/-- **The derivative of a translated, modulated Gauss–polynomial along a coordinate line.**
The translation shifts the polynomial coordinate, the modulation adds `i kᵢ`. -/
theorem hasDerivAt_pgFunT_sec (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    HasDerivAt (fun t : ℝ => pgFunT a k p (sec i x t))
      (pgFunT a k (dPoly i p) x + (Complex.I * ((k i : ℝ) : ℂ)) * pgFunT a k p x) (x i) := by
  have hsec : ∀ t : ℝ, sec i x t - a = sec i (x - a) (t - a i) := by
    intro t
    ext j
    by_cases h : j = i <;> simp [sec_apply, h]
  have h1 : HasDerivAt (fun t : ℝ => pgFun p (sec i x t - a))
      (pgFun (dPoly i p) (x - a)) (x i) := by
    have hbase := hasDerivAt_pgFun_sec i p (x - a)
    have hpt : (x - a) i = x i - a i := by simp
    rw [hpt] at hbase
    have hcomp := HasDerivAt.comp_sub_const (x i) (a i) hbase
    have hfun : (fun t : ℝ => pgFun p (sec i (x - a) (t - a i)))
        = fun t : ℝ => pgFun p (sec i x t - a) := by
      funext t
      rw [hsec]
    rw [hfun] at hcomp
    simpa [dPoly_apply] using hcomp
  have h2 := hasDerivAt_phaseFun_sec k x i
  have hprod := h1.mul h2
  simp only [Pi.mul_def, sec_self] at hprod
  have hval : (fun t : ℝ => pgFun p (sec i x t - a) * phaseFun k (sec i x t))
      = fun t : ℝ => pgFunT a k p (sec i x t) := by
    funext t
    rw [pgFunT]
  rw [hval] at hprod
  have hsimp : pgFun (dPoly i p) (x - a) * phaseFun k x
      + pgFun p (x - a) * (phaseFun k x * (Complex.I * ((k i : ℝ) : ℂ)))
      = pgFunT a k (dPoly i p) x + (Complex.I * ((k i : ℝ) : ℂ)) * pgFunT a k p x := by
    rw [pgFunT, pgFunT]
    ring
  rwa [hsimp] at hprod

theorem deriv_pgFunT_sec (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    deriv (fun t : ℝ => pgFunT a k p (sec i x t)) (x i)
      = pgFunT a k (dPoly i p) x + (Complex.I * ((k i : ℝ) : ℂ)) * pgFunT a k p x :=
  (hasDerivAt_pgFunT_sec a k i p x).deriv

/-- **Multiplication by the coordinate `xᵢ` in the translated frame**: `Xᵢ + aᵢ`. -/
def mulXTPoly (a : Vd d) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  mulXPoly i + ((a i : ℝ) : ℂ) • LinearMap.id

/-- **The momentum `πᵢ = −i∂ᵢ` in the translated, modulated frame**: `momPolyᵢ + kᵢ`. -/
def momTPoly (k : Vd d) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  momPoly i + ((k i : ℝ) : ℂ) • LinearMap.id

@[simp] theorem mulXTPoly_apply (a : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulXTPoly a i p = X i * p + ((a i : ℝ) : ℂ) • p := rfl

@[simp] theorem momTPoly_apply (k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momTPoly k i p = momPoly i p + ((k i : ℝ) : ℂ) • p := rfl

/-- **The position operator is multiplication by the coordinate**, pointwise, on the
translated core. -/
theorem pgFunT_mulXTPoly (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (mulXTPoly a i p) x = ((x i : ℝ) : ℂ) * pgFunT a k p x := by
  rw [mulXTPoly_apply, pgFunT_apply_add, pgFunT_apply_smul]
  have hx : pgFunT a k (X i * p) x = (((x - a) i : ℝ) : ℂ) * pgFunT a k p x := by
    rw [pgFunT, pgFunT]
    have := posOp_apply_eq_mul i p (x - a)
    rw [mulXPoly_apply] at this
    rw [this]
    ring
  rw [hx]
  have hxa : ((x - a) i : ℝ) = x i - a i := by simp
  rw [hxa]
  push_cast
  ring

/-- **The momentum operator is the derivative**, pointwise, on the translated, modulated
core: `momTPoly k i` is `−i` times Mathlib's `deriv` along the `i`-th coordinate line. -/
theorem pgFunT_momTPoly (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (momTPoly k i p) x
      = -Complex.I * deriv (fun t : ℝ => pgFunT a k p (sec i x t)) (x i) := by
  rw [deriv_pgFunT_sec, momTPoly_apply, pgFunT_apply_add, pgFunT_apply_smul,
    momPoly_apply' i p, pgFunT_apply_smul]
  rw [← dPoly_apply]
  linear_combination (((k i : ℝ) : ℂ) * pgFunT a k p x) * Complex.I_mul_I

end

end BookProof.ShiftedHermiteCore
