-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.hermOfMom_det
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.hermOfMom_det (p : Fin 4 → ℝ) :
    (hermOfMom p).det = ((p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 : ℝ) : ℂ) := by sorry
