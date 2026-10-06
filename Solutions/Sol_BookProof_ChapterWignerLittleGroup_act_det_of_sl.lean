-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.act_det_of_sl
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_act_det
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (A X : Matrix (Fin 2) (Fin 2) ℂ) (hA : A.det = 1) :
    (act A X).det = X.det := by

  rw [act_det, hA]; simp
