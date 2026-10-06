-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.sg_sin_sq_quarter
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution : Real.sin (Real.pi / 4) ^ 2 = 1 / 2 := by

  rw [Real.sin_pi_div_four, div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]; norm_num
