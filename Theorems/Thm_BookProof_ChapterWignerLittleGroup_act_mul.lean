-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.act_mul
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.act_mul (A B X : Matrix (Fin 2) (Fin 2) ℂ) :
    act (A * B) X = act A (act B X) := by sorry
