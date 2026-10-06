-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.act_det
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.act_det (A X : Matrix (Fin 2) (Fin 2) ℂ) :
    (act A X).det = A.det * X.det * (starRingEnd ℂ) A.det := by sorry
