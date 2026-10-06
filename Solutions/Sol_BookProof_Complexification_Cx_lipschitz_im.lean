-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.lipschitz_im
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_sub_im
open BookProof.Complexification
open BookProof.Complexification.Cx



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution : LipschitzWith 1 (Cx.im : Cx W → W) := by

  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  calc ‖x.im - y.im‖ = ‖(x - y).im‖ := by rw [sub_im]
    _ ≤ ‖x - y‖ := norm_im_le _
