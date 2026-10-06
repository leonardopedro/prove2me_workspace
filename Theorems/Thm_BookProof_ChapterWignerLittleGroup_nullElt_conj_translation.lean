-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.nullElt_conj_translation
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.nullElt_conj_translation (a b : ℂ) (ha : a * (starRingEnd ℂ) a = 1) :
    nullElt a 0 * nullElt 1 b * nullElt ((starRingEnd ℂ) a) 0 = nullElt 1 (a * a * b) := by sorry
