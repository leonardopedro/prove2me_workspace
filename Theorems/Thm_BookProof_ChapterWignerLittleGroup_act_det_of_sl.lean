-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.act_det_of_sl
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.act_det_of_sl (A X : Matrix (Fin 2) (Fin 2) ℂ) (hA : A.det = 1) :
    (act A X).det = X.det := by sorry
