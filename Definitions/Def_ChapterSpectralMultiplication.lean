import Definitions.Def_ChapterAbelianGelfandModel
import Mathlib


/-!
# The spectral theorem in multiplication form (plan GAP-2, the operator model)

`ChapterAbelianGelfandModel` proves the C*-level half of the passage "abstract
abelian algebra ⇒ measure model": a state of a commutative unital C*-algebra is
integration against a Borel probability measure, and the algebra then acts on the
corresponding `L²` space by multiplication operators.

This module turns that model into a **unitary equivalence** for a single operator.
Let `T` be a normal bounded operator on a complex Hilbert space `H` and let `ξ` be a
**cyclic** unit vector, meaning that `{f(T)ξ : f ∈ C(σ(T))}` is dense in `H`.  Then:

* `vectorState` — `f ↦ ⟪ξ, f(T)ξ⟫` is a state of `C(σ(T), ℂ)` (positivity is
  `⟪ξ, f(T)^*f(T)ξ⟫ = ‖f(T)ξ‖² ≥ 0`, unitality is `‖ξ‖ = 1`);
* `spectralMeasure` — its Riesz measure, a regular Borel *probability* measure on
  the spectrum `σ(T)`, with `integral_spectralMeasure : ⟪ξ, f(T)ξ⟫ = ∫ f dμ`;
* `norm_cfcHom_apply` — the key isometry `‖f(T)ξ‖ = ‖f‖_{L²(μ)}`;
* `spectralUnitary` — consequently the densely defined map `f ↦ f(T)ξ` extends to a
  **unitary** `U : L²(μ) ≃ₗᵢ[ℂ] H` (continuous functions are dense in `L²` of a
  regular finite measure on a compact space, and the range of `f ↦ f(T)ξ` is dense
  by cyclicity);
* `spectralUnitary_intertwines` and HEADLINE `spectral_multiplication_model` —
  `U` conjugates **multiplication by the coordinate function** `z` on `L²(μ)` into
  `T`:  `U ∘ M_z = T ∘ U`, i.e. `T = U M_z U⁻¹`.

That is the spectral theorem in its multiplication-operator form: *a normal
operator with a cyclic vector is multiplication by `z` on `L²` of a probability
measure carried by its spectrum.*  For the classification programme of the book's
chapter on selecting events it supplies the operator-level version of the missing
step — an abstractly given (singly generated) abelian algebra is *unitarily*
identified with an algebra of multiplication operators on a measure space.

Everything is `sorry`-free and `axiom`-free.  What is still not claimed is the
general von Neumann statement (no cyclic vector: one needs a direct-sum
decomposition into cyclic subspaces, and the weak closure of the model).
-/

open MeasureTheory Complex
open scoped ComplexOrder

namespace BookProof.ChapterSpectralMultiplication

open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- The spectrum of an operator carries its Borel σ-algebra. -/
noncomputable scoped instance instMeasurableSpaceSpectrum (T : H →L[ℂ] H) :
    MeasurableSpace (spectrum ℂ T) := borel _

scoped instance instBorelSpaceSpectrum (T : H →L[ℂ] H) :
    BorelSpace (spectrum ℂ T) := ⟨rfl⟩

variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

/-! ## 1. The vector state of a normal operator -/

/-- **The vector state** `f ↦ ⟪ξ, f(T)ξ⟫` of a normal operator at a vector. -/
noncomputable def vectorState : C(spectrum ℂ T, ℂ) →ₗ[ℂ] ℂ where
  toFun f := inner ℂ xi (cfcHom hT f xi)
  map_add' f g := by simp
  map_smul' c f := by simp



/-- `⟪ξ, (f̄f)(T)ξ⟫ = ‖f(T)ξ‖²`: the vector state is **positive**. -/
theorem vectorState_star_mul_self (f : C(spectrum ℂ T, ℂ)) :
    vectorState T hT xi (star f * f) = ((‖cfcHom hT f xi‖ : ℝ) ^ 2 : ℂ) := by
  have h1 : cfcHom hT (star f * f) = star (cfcHom hT f) * cfcHom hT f := by
    rw [map_mul, map_star]
  have h2 : ((star (cfcHom hT f) * cfcHom hT f) xi)
      = ContinuousLinearMap.adjoint (cfcHom hT f) ((cfcHom hT f) xi) := by
    simp [ContinuousLinearMap.star_eq_adjoint]
  simp only [vectorState_apply, h1, h2, ContinuousLinearMap.adjoint_inner_right]
  rw [inner_self_eq_norm_sq_to_K]
  norm_cast

theorem vectorState_pos (f : C(spectrum ℂ T, ℂ)) :
    0 ≤ vectorState T hT xi (star f * f) := by
  rw [vectorState_star_mul_self]
  simp [Complex.zero_le_real]



/-! ## 2. The spectral measure -/

/-- **The spectral measure of `T` at `ξ`**: the Riesz measure of the vector state, a
regular Borel measure on the spectrum. -/
noncomputable def spectralMeasure : Measure (spectrum ℂ T) :=
  stateMeasure (vectorState T hT xi) (vectorState_pos T hT xi)

instance instIsFiniteMeasureSpectralMeasure : IsFiniteMeasure (spectralMeasure T hT xi) := by
  unfold spectralMeasure
  infer_instance

instance instRegularSpectralMeasure : (spectralMeasure T hT xi).Regular := by
  unfold spectralMeasure
  infer_instance





/-! ## 3. The isometry `f ↦ f(T)ξ` -/

/-- The linear map `f ↦ f(T)ξ` from continuous functions on the spectrum to `H`. -/
noncomputable def cfcVec : C(spectrum ℂ T, ℂ) →ₗ[ℂ] H where
  toFun f := cfcHom hT f xi
  map_add' f g := by simp
  map_smul' c f := by simp



/-- **The key isometry**: `‖f(T)ξ‖` is the `L²(μ)` norm of `f`. -/
theorem norm_cfcHom_apply (f : C(spectrum ℂ T, ℂ)) :
    ‖cfcHom hT f xi‖
      = ‖ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ f‖ := by
  set mu := spectralMeasure T hT xi with hmu
  have hL : ((‖cfcHom hT f xi‖ : ℝ) ^ 2 : ℂ) = ∫ z, (starRingEnd ℂ) (f z) * f z ∂mu := by
    rw [← vectorState_star_mul_self T hT xi f]
    have h := integral_stateMeasure (vectorState T hT xi) (vectorState_pos T hT xi)
      (star f * f)
    rw [h]
    rfl
  have hR : ((‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 : ℂ)
      = ∫ z, (starRingEnd ℂ) (f z) * f z ∂mu := by
    have h1 : (inner ℂ (ContinuousMap.toLp 2 mu ℂ f) (ContinuousMap.toLp 2 mu ℂ f) : ℂ)
        = ((‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 : ℂ) := by
      rw [inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [← h1, L2.inner_def]
    refine integral_congr_ae ?_
    filter_upwards [ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) f] with z hz
    rw [RCLike.inner_apply', hz]
  have hsq : (‖cfcHom hT f xi‖ : ℝ) ^ 2 = (‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 := by
    have hc : ((‖cfcHom hT f xi‖ : ℝ) ^ 2 : ℂ)
        = ((‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 : ℂ) := by
      rw [hL, hR]
    exact_mod_cast hc
  have h1 : (0 : ℝ) ≤ ‖cfcHom hT f xi‖ := norm_nonneg _
  have h2 : (0 : ℝ) ≤ ‖ContinuousMap.toLp 2 mu ℂ f‖ := norm_nonneg _
  nlinarith [hsq, h1, h2]

/-! ## 4. The unitary and the multiplication form -/

variable (hcyc : DenseRange (cfcVec T hT xi))

/-- **The spectral unitary.**  For a cyclic vector `ξ`, the isometry `f ↦ f(T)ξ`
extends to a unitary from `L²(μ)` onto `H`. -/
noncomputable def spectralUnitary : Lp ℂ 2 (spectralMeasure T hT xi) ≃ₗᵢ[ℂ] H :=
  (LinearEquiv.refl ℂ C(spectrum ℂ T, ℂ)).extendOfIsometry
    (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ).toLinearMap
    (cfcVec T hT xi)
    (ContinuousMap.toLp_denseRange ℂ _ (μ := spectralMeasure T hT xi) (by simp))
    hcyc
    (fun f => norm_cfcHom_apply T hT xi f)



/-- The coordinate function `z ↦ z` on the spectrum. -/
noncomputable def coordFn : C(spectrum ℂ T, ℂ) :=
  ContinuousMap.restrict (spectrum ℂ T) (ContinuousMap.id ℂ)











end BookProof.ChapterSpectralMultiplication
