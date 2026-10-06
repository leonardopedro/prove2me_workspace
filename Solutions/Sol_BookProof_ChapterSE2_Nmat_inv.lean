-- Generated from ChapterSE2.lean — solution of BookProof.ChapterSE2.Nmat_inv
import Mathlib
import Definitions.Def_ChapterSE2
open BookProof.ChapterSE2



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) : Nmat a b * Nmat (-a) (-b) = 1 := by

  convert Nmat_mul a b ( -a ) ( -b ) using 1;
  norm_num [ Nmat_zero ]
