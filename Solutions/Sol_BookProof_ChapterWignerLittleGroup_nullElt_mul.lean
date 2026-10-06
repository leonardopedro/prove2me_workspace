-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.nullElt_mul
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (a b a' b' : ℂ) :
    nullElt a b * nullElt a' b' = nullElt (a * a') (a * b' + b * (starRingEnd ℂ) a') := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [nullElt, Matrix.mul_apply, Fin.sum_univ_two]
