-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.act_conjTranspose
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (A X : Matrix (Fin 2) (Fin 2) ℂ) (hX : Xᴴ = X) :
    (act A X)ᴴ = act A X := by

  simp [act, Matrix.conjTranspose_mul, hX, Matrix.mul_assoc]
