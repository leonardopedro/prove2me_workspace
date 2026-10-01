-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.norm_inner_apply_avgVec_sub_le
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_avgVec
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_apply_avgVec
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (s a : ℝ) (x y : H) :
    ‖⟪ y, G.U s (G.avgVec x a) - G.avgVec x a ⟫_ℂ‖ ≤ 2 * |s| * ‖x‖ * ‖y‖ := by

  rw [inner_sub_right, G.inner_apply_avgVec, G.inner_avgVec]
  have hint : ∀ p q : ℝ, IntervalIntegrable (fun u => ⟪ y, G.U u x ⟫_ℂ) volume p q :=
    fun p q => G.intervalIntegrable_inner x y p q
  have h1 : ((∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ) + ∫ t in s..(s + a), ⟪ y, G.U t x ⟫_ℂ)
      = ∫ t in (0:ℝ)..(s + a), ⟪ y, G.U t x ⟫_ℂ :=
    intervalIntegral.integral_add_adjacent_intervals (hint 0 s) (hint s (s + a))
  have h2 : ((∫ t in (0:ℝ)..a, ⟪ y, G.U t x ⟫_ℂ) + ∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ)
      = ∫ t in (0:ℝ)..(s + a), ⟪ y, G.U t x ⟫_ℂ :=
    intervalIntegral.integral_add_adjacent_intervals (hint 0 a) (hint a (s + a))
  have hsplit : ((∫ t in s..(s + a), ⟪ y, G.U t x ⟫_ℂ) - ∫ t in (0:ℝ)..a, ⟪ y, G.U t x ⟫_ℂ)
      = (∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ) - ∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ := by
    linear_combination h1 - h2
  rw [hsplit]
  have hb1 : ‖∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |s| := by
    have := intervalIntegral.norm_integral_le_of_norm_le_const
      (a := a) (b := s + a) (C := ‖y‖ * ‖x‖) (f := fun u => ⟪ y, G.U u x ⟫_ℂ)
      (fun t _ => G.norm_inner_le t x y)
    simpa using this
  have hb2 : ‖∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |s| := by
    have := intervalIntegral.norm_integral_le_of_norm_le_const
      (a := (0:ℝ)) (b := s) (C := ‖y‖ * ‖x‖) (f := fun u => ⟪ y, G.U u x ⟫_ℂ)
      (fun t _ => G.norm_inner_le t x y)
    simpa using this
  calc ‖(∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ) - ∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ‖
      ≤ ‖∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ‖ + ‖∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ‖ :=
        norm_sub_le _ _
    _ ≤ (‖y‖ * ‖x‖) * |s| + (‖y‖ * ‖x‖) * |s| := add_le_add hb1 hb2
    _ = 2 * |s| * ‖x‖ * ‖y‖ := by ring
