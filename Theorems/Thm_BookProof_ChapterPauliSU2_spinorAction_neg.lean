-- Generated from ChapterPauliSU2.lean — theorem BookProof.ChapterPauliSU2.spinorAction_neg
import Definitions.Def_ChapterPauliLorentz
import Mathlib
import Definitions.Def_ChapterPauliSU2
open BookProof.ChapterPauliSU2


open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

theorem BookProof.ChapterPauliSU2.spinorAction_neg (T X : Matrix (Fin 2) (Fin 2) ℂ) :
    spinorAction (-T) X = spinorAction T X := by sorry
