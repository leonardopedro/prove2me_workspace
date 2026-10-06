-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.l2pair_smul_right
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (f g : 𝓢(ℝ, ℂ)) :
    l2pair f (c • g) = c * l2pair f g := by

  unfold l2pair
  rw [← integral_const_mul]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.smul_apply, smul_eq_mul]
  ring
