import Mathlib
import BookProof.ChapterAbelianGelfandModel

/-!
# Abelian algebras with a cyclic vector: the multiplication model (plan GAP-2)

`ChapterSpectralMultiplication` proves the multiplication model for a **singly
generated** abelian algebra: a normal operator `T` with a cyclic unit vector is
multiplication by `z` on `L²(μ)`.  The obstruction recorded there — and in
`BookProof/STATUS.md` — was the passage from a singly generated abelian algebra to
an *arbitrary* one, which the classical theory obtains by producing a single
generator.

This module removes the need for a generator.  The whole argument of
`ChapterSpectralMultiplication` is carried out for an **arbitrary unital
`*`-representation** `π : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)` of the continuous functions on
a compact Hausdorff space, with a cyclic unit vector `ξ`:

* `repState` — `f ↦ ⟪ξ, π(f) ξ⟫` is a state of `C(X, ℂ)`; positivity is
  `⟪ξ, π(f̄f)ξ⟫ = ‖π(f)ξ‖²`, which uses only that `π` preserves products and stars
  (no continuity of `π` is assumed anywhere in this file);
* `repMeasure` — its Riesz measure, a regular Borel probability measure on `X`, with
  `integral_repMeasure : ⟪ξ, π(f)ξ⟫ = ∫ f dμ`;
* `norm_rep_apply` — the isometry `‖π(f)ξ‖ = ‖f‖_{L²(μ)}`;
* `cyclicRepUnitary` — hence `f ↦ π(f)ξ` extends to a **unitary**
  `U : L²(μ) ≃ₗᵢ[ℂ] H`;
* `cyclicRepUnitary_intertwines` and HEADLINE
  `cyclic_representation_multiplication_model` — `U` conjugates multiplication by
  `g` on `L²(μ)` into `π(g)`, for *every* continuous symbol `g` simultaneously.

Composing with Gelfand duality gives the form the classification programme needs
(`abelian_algebra_multiplication_model`): **every representation of a commutative
unital C\*-algebra `A` on a Hilbert space with a cyclic unit vector is unitarily
equivalent to the representation of `A` by multiplication operators on the `L²`
space of a Borel probability measure on the character space of `A`** — no
generator, no separability, no normality of a distinguished element.

Everything is `sorry`-free and `axiom`-free.
-/

open MeasureTheory Complex WeakDual
open scoped ComplexOrder

namespace BookProof.ChapterAbelianCyclicModel

open BookProof.ChapterAbelianGelfandModel

section Rep

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)

/-! ## 1. The vector state of a representation -/

/-- **The vector state** `f ↦ ⟪ξ, π(f) ξ⟫` of a representation at a vector. -/
noncomputable def repState : C(X, ℂ) →ₗ[ℂ] ℂ where
  toFun f := inner ℂ xi (pi f xi)
  map_add' f g := by simp
  map_smul' c f := by simp

omit [T2Space X] [MeasurableSpace X] [BorelSpace X] in
@[simp] theorem repState_apply (f : C(X, ℂ)) :
    repState pi xi f = inner ℂ xi (pi f xi) := rfl

omit [T2Space X] [MeasurableSpace X] [BorelSpace X] in
/-- `⟪ξ, π(f̄f)ξ⟫ = ‖π(f)ξ‖²`: the vector state is **positive**. -/
theorem repState_star_mul_self (f : C(X, ℂ)) :
    repState pi xi (star f * f) = ((‖pi f xi‖ : ℝ) ^ 2 : ℂ) := by
  have h1 : pi (star f * f) = star (pi f) * pi f := by rw [map_mul, map_star]
  have h2 : ((star (pi f) * pi f) xi)
      = ContinuousLinearMap.adjoint (pi f) ((pi f) xi) := by
    simp [ContinuousLinearMap.star_eq_adjoint]
  simp only [repState_apply, h1, h2, ContinuousLinearMap.adjoint_inner_right]
  rw [inner_self_eq_norm_sq_to_K]
  norm_cast

omit [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem repState_pos (f : C(X, ℂ)) : 0 ≤ repState pi xi (star f * f) := by
  rw [repState_star_mul_self]
  simp [Complex.zero_le_real]

omit [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem repState_one (hxi : ‖xi‖ = 1) : repState pi xi 1 = 1 := by
  simp only [repState_apply, map_one]
  simp [inner_self_eq_norm_sq_to_K, hxi]

/-! ## 2. The measure of the representation -/

/-- **The measure of the representation at `ξ`**: the Riesz measure of the vector
state, a regular Borel measure on `X`. -/
noncomputable def repMeasure : Measure X :=
  stateMeasure (repState pi xi) (repState_pos pi xi)

instance instIsFiniteMeasureRepMeasure : IsFiniteMeasure (repMeasure pi xi) := by
  unfold repMeasure
  infer_instance

instance instRegularRepMeasure : (repMeasure pi xi).Regular := by
  unfold repMeasure
  infer_instance

theorem isProbabilityMeasure_repMeasure (hxi : ‖xi‖ = 1) :
    IsProbabilityMeasure (repMeasure pi xi) :=
  isProbabilityMeasure_stateMeasure _ _ (repState_one pi xi hxi)

/-- **The measure represents the vector state**: `⟪ξ, π(f)ξ⟫ = ∫ f dμ`. -/
theorem integral_repMeasure (f : C(X, ℂ)) :
    inner ℂ xi (pi f xi) = ∫ x, f x ∂(repMeasure pi xi) :=
  integral_stateMeasure (repState pi xi) (repState_pos pi xi) f

/-! ## 3. The isometry `f ↦ π(f)ξ` -/

/-- The linear map `f ↦ π(f)ξ` from continuous functions to `H`. -/
noncomputable def repVec : C(X, ℂ) →ₗ[ℂ] H where
  toFun f := pi f xi
  map_add' f g := by simp
  map_smul' c f := by simp

omit [T2Space X] [MeasurableSpace X] [BorelSpace X] in
@[simp] theorem repVec_apply (f : C(X, ℂ)) : repVec pi xi f = pi f xi := rfl

/-- **The key isometry**: `‖π(f)ξ‖` is the `L²(μ)` norm of `f`. -/
theorem norm_rep_apply (f : C(X, ℂ)) :
    ‖pi f xi‖ = ‖ContinuousMap.toLp 2 (repMeasure pi xi) ℂ f‖ := by
  set mu := repMeasure pi xi with hmu
  have hL : ((‖pi f xi‖ : ℝ) ^ 2 : ℂ) = ∫ x, (starRingEnd ℂ) (f x) * f x ∂mu := by
    rw [← repState_star_mul_self pi xi f]
    have h := integral_stateMeasure (repState pi xi) (repState_pos pi xi) (star f * f)
    rw [h]
    rfl
  have hR : ((‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 : ℂ)
      = ∫ x, (starRingEnd ℂ) (f x) * f x ∂mu := by
    have h1 : (inner ℂ (ContinuousMap.toLp 2 mu ℂ f) (ContinuousMap.toLp 2 mu ℂ f) : ℂ)
        = ((‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 : ℂ) := by
      rw [inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [← h1, L2.inner_def]
    refine integral_congr_ae ?_
    filter_upwards [ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) f] with x hx
    rw [RCLike.inner_apply', hx]
  have hsq : (‖pi f xi‖ : ℝ) ^ 2 = (‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 := by
    have hc : ((‖pi f xi‖ : ℝ) ^ 2 : ℂ) = ((‖ContinuousMap.toLp 2 mu ℂ f‖ : ℝ) ^ 2 : ℂ) := by
      rw [hL, hR]
    exact_mod_cast hc
  have h1 : (0 : ℝ) ≤ ‖pi f xi‖ := norm_nonneg _
  have h2 : (0 : ℝ) ≤ ‖ContinuousMap.toLp 2 mu ℂ f‖ := norm_nonneg _
  nlinarith [hsq, h1, h2]

/-! ## 4. The unitary and the multiplication form -/

variable (hcyc : DenseRange (repVec pi xi))

/-- **The unitary of a cyclic representation.**  For a cyclic vector `ξ`, the isometry
`f ↦ π(f)ξ` extends to a unitary from `L²(μ)` onto `H`. -/
noncomputable def cyclicRepUnitary : Lp ℂ 2 (repMeasure pi xi) ≃ₗᵢ[ℂ] H :=
  (LinearEquiv.refl ℂ C(X, ℂ)).extendOfIsometry
    (ContinuousMap.toLp 2 (repMeasure pi xi) ℂ).toLinearMap
    (repVec pi xi)
    (ContinuousMap.toLp_denseRange ℂ _ (μ := repMeasure pi xi) (by simp))
    hcyc
    (fun f => norm_rep_apply pi xi f)

@[simp] theorem cyclicRepUnitary_toLp (f : C(X, ℂ)) :
    cyclicRepUnitary pi xi hcyc (ContinuousMap.toLp 2 (repMeasure pi xi) ℂ f)
      = pi f xi :=
  LinearEquiv.extendOfIsometry_eq _ _ _ _ _ _ f

/-- Multiplication of a continuous function inside `L²`. -/
theorem mulRep_toLp (g f : C(X, ℂ)) :
    mulRep (repMeasure pi xi) g (ContinuousMap.toLp 2 (repMeasure pi xi) ℂ f)
      = ContinuousMap.toLp 2 (repMeasure pi xi) ℂ (g * f) := by
  set mu := repMeasure pi xi with hmu
  refine Lp.ext ?_
  filter_upwards [mulRep_coeFn mu g (ContinuousMap.toLp 2 mu ℂ f),
    ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) f,
    ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) (g * f)] with x h1 h2 h3
  rw [h1, h2, h3]
  simp

/-- **The unitary carries multiplication operators into the representation.**  For every
continuous symbol `g`, `U M_g = π(g) U`. -/
theorem cyclicRepUnitary_intertwines (g : C(X, ℂ)) (u : Lp ℂ 2 (repMeasure pi xi)) :
    cyclicRepUnitary pi xi hcyc (mulRep (repMeasure pi xi) g u)
      = pi g (cyclicRepUnitary pi xi hcyc u) := by
  have hdense : DenseRange
      ((ContinuousMap.toLp 2 (repMeasure pi xi) ℂ).toLinearMap :
        C(X, ℂ) → Lp ℂ 2 (repMeasure pi xi)) :=
    ContinuousMap.toLp_denseRange ℂ _ (μ := repMeasure pi xi) (by simp)
  have hcont₁ : Continuous fun v : Lp ℂ 2 (repMeasure pi xi) =>
      cyclicRepUnitary pi xi hcyc (mulRep (repMeasure pi xi) g v) :=
    (cyclicRepUnitary pi xi hcyc).continuous.comp (mulRep (repMeasure pi xi) g).continuous
  have hcont₂ : Continuous fun v : Lp ℂ 2 (repMeasure pi xi) =>
      pi g (cyclicRepUnitary pi xi hcyc v) :=
    (pi g).continuous.comp (cyclicRepUnitary pi xi hcyc).continuous
  have hfun : (fun v : Lp ℂ 2 (repMeasure pi xi) =>
        cyclicRepUnitary pi xi hcyc (mulRep (repMeasure pi xi) g v))
      = fun v : Lp ℂ 2 (repMeasure pi xi) => pi g (cyclicRepUnitary pi xi hcyc v) := by
    refine hdense.equalizer hcont₁ hcont₂ (funext fun f => ?_)
    simp only [Function.comp_apply, ContinuousLinearMap.coe_coe]
    rw [mulRep_toLp pi xi g f, cyclicRepUnitary_toLp, cyclicRepUnitary_toLp, map_mul]
    rfl
  exact congrFun hfun u

include hcyc in
/-- **HEADLINE (the multiplication model of a cyclic abelian representation).**  Let
`π` be a unital `*`-representation of `C(X, ℂ)`, `X` compact Hausdorff, on a complex
Hilbert space `H`, with a cyclic unit vector `ξ`.  Then there is a Borel probability
measure `μ` on `X` and a unitary `U : L²(μ) ≃ H` carrying multiplication by every
continuous symbol `g` into `π(g)`.

No generator of the algebra, no separability, and no continuity of `π` are assumed. -/
theorem cyclic_representation_multiplication_model (hxi : ‖xi‖ = 1) :
    ∃ (mu : Measure X) (_ : IsProbabilityMeasure mu) (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ (g : C(X, ℂ)) (u : Lp ℂ 2 mu), U (mulRep mu g u) = pi g (U u)) ∧
      (∀ (g : C(X, ℂ)) (v : H), U.symm (pi g v) = mulRep mu g (U.symm v)) := by
  refine ⟨repMeasure pi xi, isProbabilityMeasure_repMeasure pi xi hxi,
    cyclicRepUnitary pi xi hcyc, cyclicRepUnitary_intertwines pi xi hcyc, ?_⟩
  intro g v
  have h := cyclicRepUnitary_intertwines pi xi hcyc g ((cyclicRepUnitary pi xi hcyc).symm v)
  rw [LinearIsometryEquiv.apply_symm_apply] at h
  rw [← h, LinearIsometryEquiv.symm_apply_apply]

end Rep

/-! ## 5. The Gelfand form: an arbitrary commutative unital C*-algebra -/

section Gelfand

variable {A : Type*} [CommCStarAlgebra A]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- A representation of `A` read as a representation of `C(characterSpace ℂ A, ℂ)`
through the inverse Gelfand transform. -/
noncomputable def gelfandRep (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    C(characterSpace ℂ A, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H) :=
  rho.comp ((gelfandModel A).symm : C(characterSpace ℂ A, ℂ) →⋆ₐ[ℂ] A)

@[simp] theorem gelfandRep_gelfandModel (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) (a : A) :
    gelfandRep rho (gelfandModel A a) = rho a := by
  simp [gelfandRep]

/-- **HEADLINE (the measure model of an arbitrary abelian algebra with a cyclic
vector).**  Every unital `*`-representation `ρ` of a commutative unital C\*-algebra
`A` on a complex Hilbert space `H` possessing a cyclic unit vector `ξ` (the vectors
`ρ(a)ξ` are dense) is unitarily equivalent to the representation of `A` by
multiplication operators on `L²(μ)`, for a Borel probability measure `μ` on the
character space of `A`: there is a unitary `U : L²(μ) ≃ H` with
`U ∘ M_{â} = ρ(a) ∘ U` for every `a`, where `â` is the Gelfand transform of `a`.

This is the passage from an **abstract** abelian algebra to a **concrete** measure
model without producing a single generator for the algebra — the step that the
singly generated model of `ChapterSpectralMultiplication` left open. -/
theorem abelian_algebra_multiplication_model (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
    (hxi : ‖xi‖ = 1) (hcyc : DenseRange fun a : A => rho a xi) :
    ∃ (mu : Measure (characterSpace ℂ A)) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      ∀ (a : A) (u : Lp ℂ 2 mu), U (mulRep mu (gelfandModel A a) u) = rho a (U u) := by
  have hrange : Set.range (repVec (gelfandRep rho) xi) = Set.range fun a : A => rho a xi := by
    ext v
    constructor
    · rintro ⟨f, rfl⟩
      exact ⟨(gelfandModel A).symm f, rfl⟩
    · rintro ⟨a, rfl⟩
      exact ⟨gelfandModel A a, by simp [repVec]⟩
  have hcyc' : DenseRange (repVec (gelfandRep rho) xi) := by
    rw [DenseRange, hrange]
    exact hcyc
  obtain ⟨mu, hmu, U, hU, -⟩ :=
    cyclic_representation_multiplication_model (gelfandRep rho) xi hcyc' hxi
  refine ⟨mu, hmu, U, fun a u => ?_⟩
  rw [hU (gelfandModel A a) u, gelfandRep_gelfandModel]

end Gelfand

end BookProof.ChapterAbelianCyclicModel
