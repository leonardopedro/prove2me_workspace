-- Generated from ChapterPauliSU2.lean — theorem BookProof.ChapterPauliSU2.spinorAction_comp
import Definitions.Def_ChapterPauliLorentz
import Mathlib
import Definitions.Def_ChapterPauliSU2
open BookProof.ChapterPauliSU2


open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

theorem BookProof.ChapterPauliSU2.spinorAction_comp (T₁ T₂ X : Matrix (Fin 2) (Fin 2) ℂ) :
    spinorAction (T₁ * T₂) X = spinorAction T₂ (spinorAction T₁ X) := by sorry
