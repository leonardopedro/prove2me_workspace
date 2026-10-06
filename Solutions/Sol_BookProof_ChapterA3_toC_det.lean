-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.toC_det
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 4) (Fin 4) ℝ) : (toC M).det = (M.det : ℂ) := by

  unfold toC; simp [ Matrix.det_apply' ] ;
