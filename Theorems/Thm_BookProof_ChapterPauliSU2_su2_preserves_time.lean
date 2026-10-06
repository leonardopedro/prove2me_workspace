-- Generated from ChapterPauliSU2.lean — theorem BookProof.ChapterPauliSU2.su2_preserves_time
import Mathlib
import Definitions.Def_ChapterPauliSU2
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz
open BookProof.ChapterPauliSU2


open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

theorem BookProof.ChapterPauliSU2.su2_preserves_time {T : Matrix (Fin 2) (Fin 2) ℂ} (hT : Tᴴ * T = 1)
    (x : Fin 4 → ℝ) :
    (vecOfMat (spinorAction T (hermMat x))) 0 = x 0 := by sorry
