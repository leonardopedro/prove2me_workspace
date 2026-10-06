-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.nullElt_mul
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.nullElt_mul (a b a' b' : ℂ) :
    nullElt a b * nullElt a' b' = nullElt (a * a') (a * b' + b * (starRingEnd ℂ) a') := by sorry
