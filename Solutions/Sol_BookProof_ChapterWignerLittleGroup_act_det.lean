-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.act_det
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (A X : Matrix (Fin 2) (Fin 2) ℂ) :
    (act A X).det = A.det * X.det * (starRingEnd ℂ) A.det := by

  simp [act, Matrix.det_mul, Matrix.det_conjTranspose]
