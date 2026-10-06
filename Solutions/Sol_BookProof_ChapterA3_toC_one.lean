-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.toC_one
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution : toC (1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 := by

  ext i j; by_cases hij : i = j <;> simp [ hij, toC ] ;
  simp [ hij, Matrix.one_apply ]
