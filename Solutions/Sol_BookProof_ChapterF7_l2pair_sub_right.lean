-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.l2pair_sub_right
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_ChapterF7_l2pair_integrable
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g₁ g₂ : 𝓢(ℝ, ℂ)) :
    l2pair f (g₁ - g₂) = l2pair f g₁ - l2pair f g₂ := by

  unfold l2pair
  rw [← integral_sub (l2pair_integrable f g₁) (l2pair_integrable f g₂)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.sub_apply]
  ring
