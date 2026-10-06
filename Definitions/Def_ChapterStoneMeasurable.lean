import Definitions.Def_ChapterStoneGenerator
import Mathlib


/-!
# The general Stone theorem, part VI: weak measurability implies strong continuity

This module contains the *converse* half of Stone's theorem in the separable setting.
A **weakly measurable one-parameter unitary group** is a family `U t` of unitaries with
`U 0 = 1`, `U (s + t) = U s U t` and such that `t ↦ ⟪y, U t x⟫` is measurable for all
`x y`.

Von Neumann's theorem states that on a *separable* Hilbert space every such group is
automatically strongly continuous.  The proof averages the group over an interval,
`x_a = ∫₀ᵃ U t x dt` (defined weakly, through the Riesz representation), observes the
quantitative estimate `‖U s x_a - x_a‖ ≤ 2 |s| ‖x‖`, and shows that the vectors `x_a`
span a dense subspace — this is the step that uses separability.
-/

open scoped InnerProductSpace
open Filter Topology MeasureTheory

namespace BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]



/-- A **weakly measurable one-parameter unitary group** on a complex Hilbert space. -/
structure WeakMeasurableUnitaryGroup (H : Type*) [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] where
  /-- The family of operators. -/
  U : ℝ → (H →L[ℂ] H)
  /-- The value at `0` is the identity. -/
  map_zero : U 0 = 1
  /-- The one-parameter group law. -/
  map_add : ∀ s t, U (s + t) = U s * U t
  /-- Every `U t` is isometric. -/
  norm_map : ∀ t x, ‖U t x‖ = ‖x‖
  /-- Weak measurability. -/
  weaklyMeasurable : ∀ x y : H, Measurable fun t => ⟪ y, U t x ⟫_ℂ

namespace WeakMeasurableUnitaryGroup

variable (G : WeakMeasurableUnitaryGroup H)

/-- Each `U t` is a linear isometry. -/
noncomputable def isom (t : ℝ) : H →ₗᵢ[ℂ] H :=
  ⟨(G.U t : H →ₗ[ℂ] H), G.norm_map t⟩





@[simp] theorem apply_zero (x : H) : G.U 0 x = x := by rw [G.map_zero]; rfl





theorem norm_inner_le (t : ℝ) (x y : H) : ‖⟪ y, G.U t x ⟫_ℂ‖ ≤ ‖y‖ * ‖x‖ := by
  calc ‖⟪ y, G.U t x ⟫_ℂ‖ ≤ ‖y‖ * ‖G.U t x‖ := norm_inner_le_norm _ _
    _ = ‖y‖ * ‖x‖ := by rw [G.norm_map]

/-! ## Interval integrability of the matrix coefficients -/

theorem intervalIntegrable_inner (x y : H) (a b : ℝ) :
    IntervalIntegrable (fun t => ⟪ y, G.U t x ⟫_ℂ) volume a b := by
  rw [intervalIntegrable_iff]
  refine Measure.integrableOn_of_bounded (M := ‖y‖ * ‖x‖) ?_ ?_ ?_
  · exact (measure_Ioc_lt_top).ne
  · exact ((G.weaklyMeasurable x y).stronglyMeasurable).aestronglyMeasurable
  · exact Eventually.of_forall (fun t => G.norm_inner_le t x y)

/-! ## The averaged vectors `x_a = ∫₀ᵃ U t x dt` -/

/-- The linear functional `y ↦ conj ∫₀ᵃ ⟪y, U t x⟫ dt`. -/
noncomputable def avgFunctional (x : H) (a : ℝ) : H →L[ℂ] ℂ :=
  LinearMap.mkContinuous
    { toFun := fun y => starRingEnd ℂ (∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ)
      map_add' := by
        intro y z
        rw [← RingHom.map_add]
        congr 1
        rw [← intervalIntegral.integral_add (G.intervalIntegrable_inner x y 0 a)
          (G.intervalIntegrable_inner x z 0 a)]
        congr 1
        funext t
        rw [inner_add_left]
      map_smul' := by
        intro c y
        simp only [RingHom.id_apply]
        have h : (fun t => ⟪ c • y, G.U t x ⟫_ℂ)
            = fun t => (starRingEnd ℂ) c * ⟪ y, G.U t x ⟫_ℂ := by
          funext t
          rw [inner_smul_left]
        rw [h, intervalIntegral.integral_const_mul, map_mul]
        simp }
    (|a| * ‖x‖) (by
      intro y
      simp only [LinearMap.coe_mk, AddHom.coe_mk, RCLike.norm_conj]
      have hbound : ‖∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |a - 0| := by
        refine intervalIntegral.norm_integral_le_of_norm_le_const ?_
        intro t _
        exact G.norm_inner_le t x y
      calc ‖∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |a - 0| := hbound
        _ = |a| * ‖x‖ * ‖y‖ := by rw [sub_zero]; ring)

/-- The averaged vector `x_a = ∫₀ᵃ U t x dt`, defined weakly. -/
noncomputable def avgVec [CompleteSpace H] (x : H) (a : ℝ) : H :=
  (InnerProductSpace.toDual ℂ H).symm (G.avgFunctional x a)



/-! ## The estimate `‖U s x_a - x_a‖ ≤ 2 |s| ‖x‖` -/











/-! ## The set of strong-continuity vectors -/

/-- The submodule of vectors at which the group is strongly continuous at `0`. -/
def contSubmodule : Submodule ℂ H where
  carrier := {v : H | Tendsto (fun s : ℝ => G.U s v) (𝓝 0) (𝓝 v)}
  add_mem' := by
    intro v w hv hw
    have h : (fun s : ℝ => G.U s (v + w)) = fun s : ℝ => G.U s v + G.U s w := by
      funext s; exact ContinuousLinearMap.map_add (G.U s) v w
    change Tendsto (fun s : ℝ => G.U s (v + w)) (𝓝 0) (𝓝 (v + w))
    rw [h]
    exact hv.add hw
  zero_mem' := by
    have h : (fun s : ℝ => G.U s (0 : H)) = fun _ : ℝ => (0 : H) := by
      funext s; exact ContinuousLinearMap.map_zero (G.U s)
    change Tendsto (fun s : ℝ => G.U s (0 : H)) (𝓝 0) (𝓝 (0 : H))
    rw [h]
    exact tendsto_const_nhds
  smul_mem' := by
    intro c v hv
    have h : (fun s : ℝ => G.U s (c • v)) = fun s : ℝ => c • G.U s v := by
      funext s; exact ContinuousLinearMap.map_smul (G.U s) c v
    change Tendsto (fun s : ℝ => G.U s (c • v)) (𝓝 0) (𝓝 (c • v))
    rw [h]
    exact hv.const_smul c



/-! ## The span of the averaged vectors -/

/-- The set of all averaged vectors `∫₀ᵃ U t x dt`. -/
def avgSet [CompleteSpace H] : Set H := {v : H | ∃ (x : H) (a : ℝ), v = G.avgVec x a}

/-- The linear span of the averaged vectors. -/
def avgSpan [CompleteSpace H] : Submodule ℂ H := Submodule.span ℂ G.avgSet



/-! ## Separability: the averaged vectors span a dense subspace -/







) = closure (G.avgSpan : Set H) := rfl
  rw [h2] at this
  simpa using this

/-!  un t => ?_
  simp only [Function.comp_apply]
  rw [G.apply_apply]
  ring_nf

end WeakMeasurableUnitaryGroup

end BookProof.ChapterStoneMeasurable
