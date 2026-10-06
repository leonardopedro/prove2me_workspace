-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.lipschitz_re
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_sub_re
open BookProof.Complexification
open BookProof.Complexification.Cx



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution : LipschitzWith 1 (Cx.re : Cx W → W) := by

  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  calc ‖x.re - y.re‖ = ‖(x - y).re‖ := by rw [sub_re]
    _ ≤ ‖x - y‖ := norm_re_le _
