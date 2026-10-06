-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.act_mul
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (A B X : Matrix (Fin 2) (Fin 2) ℂ) :
    act (A * B) X = act A (act B X) := by

  simp [act, Matrix.conjTranspose_mul, Matrix.mul_assoc]
