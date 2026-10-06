-- Generated from ChapterPauliSU2.lean — theorem BookProof.ChapterPauliSU2.spinorAction_trace_of_unitary
import Definitions.Def_ChapterPauliLorentz
import Mathlib
import Definitions.Def_ChapterPauliSU2
open BookProof.ChapterPauliSU2


open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

theorem BookProof.ChapterPauliSU2.spinorAction_trace_of_unitary {T : Matrix (Fin 2) (Fin 2) ℂ}
    (hT : Tᴴ * T = 1) (X : Matrix (Fin 2) (Fin 2) ℂ) :
    (spinorAction T X).trace = X.trace := by sorry
