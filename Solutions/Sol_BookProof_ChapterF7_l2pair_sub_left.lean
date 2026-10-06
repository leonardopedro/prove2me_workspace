-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.l2pair_sub_left
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_ChapterF7_l2pair_integrable
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f₁ f₂ g : 𝓢(ℝ, ℂ)) :
    l2pair (f₁ - f₂) g = l2pair f₁ g - l2pair f₂ g := by

  unfold l2pair
  rw [← integral_sub (l2pair_integrable f₁ g) (l2pair_integrable f₂ g)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.sub_apply, map_sub]
  ring
