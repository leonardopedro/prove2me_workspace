-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.momentum_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_ChapterF7_schwartz_integration_by_parts
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_apply
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsL2Symmetric momentum := by

  intro f g
  have hL : l2pair (momentum f) g
      = Complex.I * ∫ x, (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x) * g x := by
    unfold l2pair
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [momentum_apply, map_mul, map_neg, Complex.conj_I]
    ring
  have hR : l2pair f (momentum g)
      = (-Complex.I) * ∫ x, (starRingEnd ℂ) (f x) * deriv (g : ℝ → ℂ) x := by
    unfold l2pair
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [momentum_apply]
    ring
  rw [hL, hR, schwartz_integration_by_parts]
  ring
