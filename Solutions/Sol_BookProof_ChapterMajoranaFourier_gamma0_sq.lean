-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.gamma0_sq
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : dgamma 0 * dgamma 0 = 1 := by

  unfold dgamma BookProof.ChapterA3.mgamma;
  unfold mgammaZ;    ext i j; fin_cases i <;> fin_cases j <;> norm_num [ Complex.ext_iff,
      Matrix.mul_apply ] ;
  all_goals norm_cast;
