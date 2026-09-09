import Mathlib
import BookProof.ChapterH1
import BookProof.ChapterH4
import BookProof.ChapterH6
import BookProof.ChapterH7
import BookProof.ChapterH8
import BookProof.ChapterH8Bases

/-!
# Chapter H9 — the SIRK numerical ranges nest (plan `PLAN_LEAN_SPECIALIST_SIRK_NESTED.md`)

`ChapterH8` proves that the SIRK *approximants* nest: the order-`n` reduced
generator is a block of the order-`n+1` one, and the coarse approximant is the
fine one projected back into the coarse Krylov subspace.  This module proves the
**spectral** side of the same statement: the sets of frequencies the reduced
generators can see nest as well,

`W(Bₘ) ⊆ W(Bₙ) ⊆ W(X)`  for `m ≤ n`,

where `W` is the numerical range (`ChapterH1.numericalRange`, here in its bounded
operator form `numRange`) and `Bₖ = compress Vₖ X` is the order-`k` reduced
generator.  Refining the order can only *add* Rayleigh quotients, and never adds
one that the full generator does not already have: the Krylov tower manufactures
no frequencies of its own, and no order sees a frequency outside `W(X)`.

## Deliverables

* **the compression only sees frequencies of `X`** — `numRange_compress_subset`
  (`W(V∗XV) ⊆ W(X)` for an isometric `V`), with the underlying isometry lemma
  `norm_map_of_adjoint_comp` and the quantitative form
  `numRange_subset_closedBall` (`W(X)` lies in the disc of radius `‖X‖`, hence so
  does every `W(Bₖ)`, uniformly in the order);
* **the ranges nest** — `numRange_compress_mono` for an abstract nested pair
  `Vₙ = Vₘ ∘ J`, `numRange_compress_chain` for the two inclusions together, and
  `convexHull_numRange_compress_mono` for the convex hulls (the sets Crouzeix's
  inequality is evaluated on);
* **the operator norms nest** — `norm_compress_le` (`‖Bₖ‖ ≤ ‖X‖`) and
  `norm_compress_mono` (`‖Bₘ‖ ≤ ‖Bₙ‖`), from `norm_adjoint_le_one_of_isometry`;
* **the Ritz values nest** — `ritz_mem_numRange` (an eigenvalue of a compression
  is a Rayleigh quotient of `X`), `ritz_mem_numRange_compress` (an eigenvalue at
  the coarse order is a Rayleigh quotient at the fine order), and
  `ritz_re_mem_Icc_of_fine`: real bounds established at the fine order bind the
  coarse Ritz values;
* **the Ritz spectra nest** — in finite dimensions every spectral value is an
  eigenvalue (`exists_unit_eigenvector`), so
  `spectrum_compress_subset_numRange` (`σ(B) ⊆ W(X)`),
  `spectrum_compress_subset_numRange_compress` (`σ(Bₘ) ⊆ W(Bₙ)`) and their
  hypothesis-free instance `spectrum_compress_subset_numRange_orthonormal`;
* **positivity and self-adjoint bounds survive compression** —
  `compress_nonneg`, `compress_re_inner_mem_Icc`;
* **the best-approximation error is antitone in the order** —
  `norm_sub_starProjection_antitone` (nested subspaces approximate better) and
  `krylov_bestApprox_antitone`: for `m ≤ n` the order-`n` Krylov subspace
  approximates any target at least as well as the order-`m` one, unconditionally
  (the Krylov subspaces are finite-dimensional, `krylovSpan_finiteDimensional`),
  with `krylov_bestApprox_tendsto_zero`: if the Krylov flag is dense (a cyclic
  seed) the error tends to `0` — still with no rate;
* **the hypotheses are realized** — `numRange_compress_orthonormal_mono` and the
  headline tower `sirk_numRange_nested_orders` for any nested pair of orthonormal
  bases, and `sirk_numRange_krylov` for the orthonormal Krylov bases the method
  actually builds (`ChapterH8Bases.krylovEmbedding`).

## Correspondence

`ChapterH1.numericalRange` and `eigenvalue_mem_numericalRange` supply the
numerical range and the eigenvalue inclusion; `ChapterH6.krylov_rayleigh_transfer`
is the Rayleigh–Ritz identity `⟪y, (V∗XV) y⟫ = ⟪Vy, X (Vy)⟫` that drives every
proof here; `ChapterH7` supplies the self-adjoint facts; `ChapterH8` /
`ChapterH8Bases` supply the nesting `Vₙ = Vₘ ∘ J` and its realization by nested
orthonormal (Krylov) bases.

## The exact boundary

These are inclusions of *sets of Rayleigh quotients*.  Nothing here says that the
numerical ranges *converge* to `W(X)`, and nothing here is Crouzeix's inequality:
the constant relating `sup_{W(B)} |f|` to `‖f(B)‖` remains a named hypothesis in
`ChapterH4.sirk_error_bound_decay`, never an axiom.  Note also the honest
direction: since `W(Bₘ) ⊆ W(Bₙ)`, a bound of the shape `C · sup_{W(B)} |f|` is
*non-decreasing* in the order — the band decay of `ChapterH6` comes from the
approximation quality, not from shrinking numerical ranges.  Convexity of the
numerical range (Toeplitz–Hausdorff) is not used and not claimed.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterH9

open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap

section NumRange

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

/-- The **numerical range** of a bounded operator: the set of Rayleigh quotients
`⟪x, X x⟫` over unit vectors.  Bounded-operator form of
`ChapterH1.numericalRange`. -/
def numRange (X : E →L[ℂ] E) : Set ℂ := numericalRange (X : E →ₗ[ℂ] E)

omit [CompleteSpace E] in
theorem mem_numRange_iff {X : E →L[ℂ] E} {c : ℂ} :
    c ∈ numRange X ↔ ∃ x : E, ‖x‖ = 1 ∧ (inner ℂ x (X x) : ℂ) = c := Iff.rfl

omit [CompleteSpace E] in
theorem mem_numRange {X : E →L[ℂ] E} (x : E) (hx : ‖x‖ = 1) :
    (inner ℂ x (X x) : ℂ) ∈ numRange X := ⟨x, hx, rfl⟩

/-! ## Isometric embeddings -/

/-- `V∗V = 1` makes `V` an isometry. -/
theorem norm_map_of_adjoint_comp {V : F →L[ℂ] E}
    (hV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F) (x : F) : ‖V x‖ = ‖x‖ := by
  have hx : (adjoint V) (V x) = x := congrArg (fun f : F →L[ℂ] F => f x) hV
  have h : (inner ℂ (V x) (V x) : ℂ) = inner ℂ x x := by
    rw [← adjoint_inner_left V x (V x), hx]
  have h2 := congrArg (RCLike.re (K := ℂ)) h
  rw [inner_self_eq_norm_sq (V x), inner_self_eq_norm_sq x] at h2
  nlinarith [norm_nonneg (V x), norm_nonneg x]

omit [CompleteSpace E] [CompleteSpace F] in
/-- An isometric embedding has operator norm at most `1`. -/
theorem norm_le_one_of_isometry (V : F →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    ‖V‖ ≤ 1 :=
  ContinuousLinearMap.opNorm_le_bound _ zero_le_one fun x => by rw [hViso, one_mul]

/-- The adjoint of an isometric embedding is a contraction. -/
theorem norm_adjoint_le_one_of_isometry (V : F →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    ‖adjoint V‖ ≤ 1 := by
  rw [LinearIsometryEquiv.norm_map adjoint V]
  exact norm_le_one_of_isometry V hViso

/-! ## The compression sees only frequencies of `X` -/

/-- **The numerical range of a compression is contained in that of the full
operator.**  Every Rayleigh quotient of `B = V∗XV` is a Rayleigh quotient of `X`
along the embedded subspace (`ChapterH6.krylov_rayleigh_transfer`). -/
theorem numRange_compress_subset (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) : numRange (compress V X) ⊆ numRange X := by
  rintro c ⟨y, hy, rfl⟩
  exact ⟨V y, by rw [hViso, hy], (krylov_rayleigh_transfer V X y).symm⟩

omit [CompleteSpace E] in
/-- Every Rayleigh quotient has modulus at most `‖X‖`: the numerical range lies
in the closed disc of radius `‖X‖`. -/
theorem numRange_subset_closedBall (X : E →L[ℂ] E) :
    numRange X ⊆ Metric.closedBall (0 : ℂ) ‖X‖ := by
  rintro c ⟨x, hx, rfl⟩
  have hcs : ‖(inner ℂ x (X x) : ℂ)‖ ≤ ‖x‖ * ‖X x‖ := norm_inner_le_norm _ _
  have hXb : ‖X x‖ ≤ ‖X‖ := by simpa [hx] using X.le_opNorm x
  simp only [Metric.mem_closedBall, dist_zero_right]
  calc ‖(inner ℂ x (X x) : ℂ)‖ ≤ ‖x‖ * ‖X x‖ := hcs
    _ = ‖X x‖ := by rw [hx, one_mul]
    _ ≤ ‖X‖ := hXb

/-- **No order sees a frequency beyond `‖X‖`**, uniformly in the order. -/
theorem numRange_compress_subset_closedBall (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    numRange (compress V X) ⊆ Metric.closedBall (0 : ℂ) ‖X‖ :=
  (numRange_compress_subset V X hViso).trans (numRange_subset_closedBall X)

/-! ## The ranges nest -/

/-- Compressing twice is compressing once: for `Vₙ = Vₘ ∘ J` the coarse
compression is the `J`-compression of the fine one (`ChapterH8`, operator
form). -/
theorem compress_compress (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) :
    compress Vn X = compress J (compress Vm X) :=
  sirk_compression_block_op Vn Vm J X hJ

/-- **The numerical ranges nest.**  If the coarse embedding factors through the
fine one (`Vₙ = Vₘ ∘ J` with `J` isometric), the coarse reduced generator sees a
subset of the frequencies of the fine one. -/
theorem numRange_compress_mono (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖) :
    numRange (compress Vn X) ⊆ numRange (compress Vm X) := by
  rw [compress_compress Vn Vm J X hJ]
  exact numRange_compress_subset J (compress Vm X) hJiso

/-- **The chain `W(Bₘ) ⊆ W(Bₙ) ⊆ W(X)`.** -/
theorem numRange_compress_chain (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖)
    (hViso : ∀ x : G, ‖Vm x‖ = ‖x‖) :
    numRange (compress Vn X) ⊆ numRange (compress Vm X)
      ∧ numRange (compress Vm X) ⊆ numRange X :=
  ⟨numRange_compress_mono Vn Vm J X hJ hJiso, numRange_compress_subset Vm X hViso⟩

/-- The convex hulls nest as well — the sets on which a Crouzeix-type bound is
evaluated.  (Convexity of the numerical range itself is not claimed.) -/
theorem convexHull_numRange_compress_mono (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E)
    (J : F →L[ℂ] G) (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖) :
    convexHull ℝ (numRange (compress Vn X)) ⊆ convexHull ℝ (numRange (compress Vm X)) :=
  convexHull_mono (numRange_compress_mono Vn Vm J X hJ hJiso)

/-! ## The operator norms nest -/

/-- **The compression is a contraction of `X`**: `‖V∗XV‖ ≤ ‖X‖`. -/
theorem norm_compress_le (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    ‖compress V X‖ ≤ ‖X‖ := by
  refine ContinuousLinearMap.opNorm_le_bound _ (norm_nonneg X) fun y => ?_
  have h1 : ‖compress V X y‖ ≤ ‖adjoint V‖ * ‖X (V y)‖ := by
    simpa [compress] using (adjoint V).le_opNorm (X (V y))
  have h2 : ‖X (V y)‖ ≤ ‖X‖ * ‖y‖ := by
    calc ‖X (V y)‖ ≤ ‖X‖ * ‖V y‖ := X.le_opNorm (V y)
      _ = ‖X‖ * ‖y‖ := by rw [hViso]
  have h3 : ‖adjoint V‖ * ‖X (V y)‖ ≤ 1 * (‖X‖ * ‖y‖) := by
    refine mul_le_mul (norm_adjoint_le_one_of_isometry V hViso) h2 (norm_nonneg _) zero_le_one
  linarith [h1, h3]

/-- **The norms nest**: `‖Bₘ‖ ≤ ‖Bₙ‖` for the coarse and fine reduced
generators. -/
theorem norm_compress_mono (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖) :
    ‖compress Vn X‖ ≤ ‖compress Vm X‖ := by
  rw [compress_compress Vn Vm J X hJ]
  exact norm_compress_le J (compress Vm X) hJiso

/-! ## The Ritz values nest -/

/-- **A Ritz value is a Rayleigh quotient of `X`.**  Every eigenvalue of a reduced
generator lies in `W(X)`. -/
theorem ritz_mem_numRange (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress V X y = lam • y) :
    lam ∈ numRange X :=
  numRange_compress_subset V X hViso
    (eigenvalue_mem_numericalRange (compress V X : F →ₗ[ℂ] F) lam y hy heig)

/-- **Ritz values nest**: an eigenvalue of the coarse reduced generator is a
Rayleigh quotient of the fine one — refining the order retains it. -/
theorem ritz_mem_numRange_compress (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress Vn X y = lam • y) :
    lam ∈ numRange (compress Vm X) :=
  numRange_compress_mono Vn Vm J X hJ hJiso
    (eigenvalue_mem_numericalRange (compress Vn X : F →ₗ[ℂ] F) lam y hy heig)

/-- **Bounds proved at the fine order bind the coarse Ritz values.**  If every
Rayleigh quotient of the order-`n` reduced generator has real part in `[a, b]`,
then so does every eigenvalue of the order-`m` one, `m ≤ n`. -/
theorem ritz_re_mem_Icc_of_fine (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress Vn X y = lam • y)
    {a b : ℝ} (hlow : ∀ x : G, ‖x‖ = 1 → a ≤ (inner ℂ x (compress Vm X x) : ℂ).re)
    (hhigh : ∀ x : G, ‖x‖ = 1 → (inner ℂ x (compress Vm X x) : ℂ).re ≤ b) :
    a ≤ lam.re ∧ lam.re ≤ b := by
  obtain ⟨x, hx, hval⟩ :=
    ritz_mem_numRange_compress Vn Vm J X hJ hJiso hy heig
  exact ⟨hval ▸ hlow x hx, hval ▸ hhigh x hx⟩

/-! ## Positivity and self-adjoint bounds survive compression -/

/-- The compression of a positive operator is positive. -/
theorem compress_nonneg (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hX : ∀ x : E, 0 ≤ (inner ℂ x (X x) : ℂ).re) (y : F) :
    0 ≤ (inner ℂ y (compress V X y) : ℂ).re := by
  rw [krylov_rayleigh_transfer]
  exact hX (V y)

/-- Real bounds on the quadratic form of `X` pass to every compression: the
reduced generators of a self-adjoint `X` inherit its spectral window. -/
theorem compress_re_inner_mem_Icc (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) {a b : ℝ}
    (hlow : ∀ x : E, ‖x‖ = 1 → a ≤ (inner ℂ x (X x) : ℂ).re)
    (hhigh : ∀ x : E, ‖x‖ = 1 → (inner ℂ x (X x) : ℂ).re ≤ b)
    (y : F) (hy : ‖y‖ = 1) :
    a ≤ (inner ℂ y (compress V X y) : ℂ).re
      ∧ (inner ℂ y (compress V X y) : ℂ).re ≤ b := by
  have hVy : ‖V y‖ = 1 := by rw [hViso, hy]
  rw [krylov_rayleigh_transfer]
  exact ⟨hlow (V y) hVy, hhigh (V y) hVy⟩

/-! ## The Ritz spectra nest -/

omit [CompleteSpace E] [CompleteSpace F] in
/-- In finite dimensions every spectral value is an eigenvalue, and eigenvectors
can be normalized. -/
theorem exists_unit_eigenvector [FiniteDimensional ℂ F] (A : F →L[ℂ] F) {lam : ℂ}
    (hlam : lam ∈ spectrum ℂ (A : F →ₗ[ℂ] F)) : ∃ y : F, ‖y‖ = 1 ∧ A y = lam • y := by
  obtain ⟨v, hmem, hv0⟩ :=
    (Module.End.hasEigenvalue_iff_mem_spectrum.mpr hlam).exists_hasEigenvector
  have hAv : A v = lam • v := by
    simp only [Module.End.mem_genEigenspace_one, ContinuousLinearMap.coe_coe] at hmem
    exact hmem
  have hnv : (‖v‖ : ℝ) ≠ 0 := norm_ne_zero_iff.mpr hv0
  refine ⟨((‖v‖ : ℂ))⁻¹ • v, ?_, ?_⟩
  · rw [norm_smul]
    simp [hnv]
  · rw [map_smul, hAv, smul_comm]

/-- **The Ritz spectrum lies in the numerical range of `X`.**  Every spectral
value of a finite-dimensional reduced generator is a Rayleigh quotient of the
full generator. -/
theorem spectrum_compress_subset_numRange [FiniteDimensional ℂ F] (V : F →L[ℂ] E)
    (X : E →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    spectrum ℂ ((compress V X : F →ₗ[ℂ] F)) ⊆ numRange X := by
  intro lam hlam
  obtain ⟨y, hy, heig⟩ := exists_unit_eigenvector (compress V X) hlam
  exact ritz_mem_numRange V X hViso hy heig

/-- **The Ritz spectra nest.**  Every spectral value of the coarse reduced
generator is a Rayleigh quotient of the fine one. -/
theorem spectrum_compress_subset_numRange_compress [FiniteDimensional ℂ F]
    (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G) (X : E →L[ℂ] E)
    (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖) :
    spectrum ℂ ((compress Vn X : F →ₗ[ℂ] F)) ⊆ numRange (compress Vm X) := by
  intro lam hlam
  obtain ⟨y, hy, heig⟩ := exists_unit_eigenvector (compress Vn X) hlam
  exact ritz_mem_numRange_compress Vn Vm J X hJ hJiso hy heig

end NumRange

/-! ## The hypotheses are realized: nested orthonormal (Krylov) bases -/

section Realization

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-- The embedding of an orthonormal family is isometric. -/
theorem orthonormalEmbedding_norm_map {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w)
    (x : EuclideanSpace ℂ (Fin m)) : ‖orthonormalEmbedding w hw x‖ = ‖x‖ :=
  norm_map_of_adjoint_comp (orthonormalEmbedding_adjoint_comp w hw) x

/-- The coordinate inclusion is isometric. -/
theorem coordIncl_norm_map {m n : ℕ} (hmn : m ≤ n) (x : EuclideanSpace ℂ (Fin m)) :
    ‖coordIncl hmn x‖ = ‖x‖ :=
  norm_map_of_adjoint_comp (coordIncl_adjoint_comp hmn) x

/-- **The numerical ranges nest for nested orthonormal bases**, with no abstract
hypotheses left. -/
theorem numRange_compress_orthonormal_mono {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    numRange (compress (orthonormalEmbedding w hw) X)
      ⊆ numRange (compress (orthonormalEmbedding w' hw') X) :=
  numRange_compress_mono _ _ (coordIncl hmn) X
    (orthonormalEmbedding_nested hmn w w' hw hw' hnest) (coordIncl_norm_map hmn)

/-- **Headline — the frequency windows of the SIRK orders nest.**  For any two
nested orthonormal bases (orders `m ≤ n`), the coarse reduced generator sees a
subset of the frequencies of the fine one, which in turn sees only frequencies of
the full generator, and both are bounded by `‖X‖`:
`W(Bₘ) ⊆ W(Bₙ) ⊆ W(X) ⊆ closedBall 0 ‖X‖`, with `‖Bₘ‖ ≤ ‖Bₙ‖ ≤ ‖X‖`. -/
theorem sirk_numRange_nested_orders {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    numRange (compress (orthonormalEmbedding w hw) X)
        ⊆ numRange (compress (orthonormalEmbedding w' hw') X)
      ∧ numRange (compress (orthonormalEmbedding w' hw') X) ⊆ numRange X
      ∧ numRange X ⊆ Metric.closedBall (0 : ℂ) ‖X‖
      ∧ ‖compress (orthonormalEmbedding w hw) X‖
          ≤ ‖compress (orthonormalEmbedding w' hw') X‖
      ∧ ‖compress (orthonormalEmbedding w' hw') X‖ ≤ ‖X‖ :=
  ⟨numRange_compress_orthonormal_mono hmn X w w' hw hw' hnest,
   numRange_compress_subset _ X (orthonormalEmbedding_norm_map w' hw'),
   numRange_subset_closedBall X,
   norm_compress_mono _ _ (coordIncl hmn) X
     (orthonormalEmbedding_nested hmn w w' hw hw' hnest) (coordIncl_norm_map hmn),
   norm_compress_le _ X (orthonormalEmbedding_norm_map w' hw')⟩

/-- **The Ritz spectra nest for nested orthonormal bases.**  The spectrum of the
order-`m` reduced generator sits inside the numerical range of the order-`n` one,
and inside that of the full generator. -/
theorem spectrum_compress_subset_numRange_orthonormal {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    spectrum ℂ ((compress (orthonormalEmbedding w hw) X :
        EuclideanSpace ℂ (Fin m) →ₗ[ℂ] EuclideanSpace ℂ (Fin m)))
      ⊆ numRange (compress (orthonormalEmbedding w' hw') X)
      ∩ numRange X := by
  intro lam hlam
  refine ⟨spectrum_compress_subset_numRange_compress _ _ (coordIncl hmn) X
      (orthonormalEmbedding_nested hmn w w' hw hw' hnest) (coordIncl_norm_map hmn) hlam,
    spectrum_compress_subset_numRange _ X (orthonormalEmbedding_norm_map w hw) hlam⟩

/-- **The tower for the Krylov flag itself.**  At orders `m ≤ n` at which the
Krylov sequence has not broken down, the order-`m` reduced generator sees a subset
of the frequencies of the order-`n` one, and neither sees a frequency outside
`W(X)`. -/
theorem sirk_numRange_krylov {m n : ℕ} (hmn : m ≤ n) (H : E →ₗ[ℂ] E) (v : E)
    (X : E →L[ℂ] E) (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    numRange (compress (krylovEmbedding H v (krylov_li_of_le hmn hli)) X)
        ⊆ numRange (compress (krylovEmbedding H v hli) X)
      ∧ numRange (compress (krylovEmbedding H v hli) X) ⊆ numRange X := by
  refine ⟨numRange_compress_orthonormal_mono hmn X _ _
    (krylovOrthonormal_orthonormal H v (krylov_li_of_le hmn hli))
    (krylovOrthonormal_orthonormal H v hli)
    (fun i => by simp) , ?_⟩
  exact numRange_compress_subset _ X (orthonormalEmbedding_norm_map _ _)

end Realization

/-! ## The best-approximation error is antitone in the order -/

section BestApprox

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The orthogonal projection is the best approximation from the subspace. -/
theorem norm_sub_starProjection_le (K : Submodule ℂ E) [K.HasOrthogonalProjection]
    (u w : E) (hw : w ∈ K) : ‖u - K.starProjection u‖ ≤ ‖u - w‖ := by
  rw [Submodule.starProjection_minimal]
  refine ciInf_le_of_le ⟨0, ?_⟩ (⟨w, hw⟩ : K) le_rfl
  rintro r ⟨x, rfl⟩
  positivity

/-- **Nested subspaces approximate better.**  If `K ≤ L` then the orthogonal
projection onto `L` is at least as good an approximation as the one onto `K`
(the projection minimizes the distance to the subspace). -/
theorem norm_sub_starProjection_antitone (K L : Submodule ℂ E)
    [K.HasOrthogonalProjection] [L.HasOrthogonalProjection] (hKL : K ≤ L) (v : E) :
    ‖v - L.starProjection v‖ ≤ ‖v - K.starProjection v‖ :=
  norm_sub_starProjection_le L v (K.starProjection v) (hKL (K.starProjection_apply_mem v))

/-- The Krylov subspaces are finite-dimensional, hence closed: the orthogonal
projection onto them exists. -/
instance krylovSpan_finiteDimensional (H : E →ₗ[ℂ] E) (v : E) (m : ℕ) :
    FiniteDimensional ℂ (krylovSpan H v m) := by
  have hfin : {x | ∃ i < m, x = (H ^ i) v}.Finite := by
    apply Set.Finite.subset (Set.finite_range (fun i : Fin m => (H ^ (i : ℕ)) v))
    rintro x ⟨i, hi, rfl⟩
    exact ⟨⟨i, hi⟩, rfl⟩
  exact FiniteDimensional.span_of_finite ℂ hfin

/-- **The Krylov best-approximation error is antitone in the order.**  This is the
*unconditional* form of the band nesting: whatever the target `u`, the order-`n`
Krylov subspace approximates it at least as well as the order-`m` one, for
`m ≤ n` — no Crouzeix inequality and no convergence rate involved. -/
theorem krylov_bestApprox_antitone (H : E →ₗ[ℂ] E) (v : E) {m n : ℕ} (hmn : m ≤ n) (u : E) :
    ‖u - (krylovSpan H v n).starProjection u‖ ≤ ‖u - (krylovSpan H v m).starProjection u‖ :=
  norm_sub_starProjection_antitone _ _ (krylovSpan_mono hmn) u

/-- **The nested family collapses when the Krylov flag is dense.**  If the union
of the Krylov subspaces is dense — the seed is cyclic for `H` — then the
best-approximation error tends to `0` for every target.  No *rate* is claimed:
that is exactly where an analytic input such as Crouzeix's inequality would be
needed. -/
theorem krylov_bestApprox_tendsto_zero (H : E →ₗ[ℂ] E) (v u : E)
    (hdense : Dense ((⨆ n : ℕ, krylovSpan H v n : Submodule ℂ E) : Set E)) :
    Filter.Tendsto (fun n : ℕ => ‖u - (krylovSpan H v n).starProjection u‖)
      Filter.atTop (nhds 0) := by
  rw [Metric.tendsto_atTop]
  intro eps heps
  obtain ⟨w, hw, hwd⟩ := hdense.exists_dist_lt u heps
  have hmono : Monotone (fun n : ℕ => krylovSpan H v n) := fun _ _ hab => krylovSpan_mono hab
  have hdir : Directed (fun x1 x2 : Submodule ℂ E => x1 ≤ x2) (fun n : ℕ => krylovSpan H v n) :=
    hmono.directed_le
  obtain ⟨N, hN⟩ := (Submodule.mem_iSup_of_directed _ hdir).mp hw
  refine ⟨N, fun n hn => ?_⟩
  have h1 : ‖u - (krylovSpan H v n).starProjection u‖ ≤ ‖u - w‖ :=
    norm_sub_starProjection_le _ u w (krylovSpan_mono hn hN)
  have h2 : ‖u - w‖ < eps := by simpa [dist_eq_norm] using hwd
  have h3 : dist ‖u - (krylovSpan H v n).starProjection u‖ 0
      = ‖u - (krylovSpan H v n).starProjection u‖ := by
    simp
  rw [h3]
  exact lt_of_le_of_lt h1 h2

end BestApprox

end BookProof.ChapterH9

end
