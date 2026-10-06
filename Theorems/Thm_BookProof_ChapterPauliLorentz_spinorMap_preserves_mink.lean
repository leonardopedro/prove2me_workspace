-- Generated from ChapterPauliLorentz.lean — theorem BookProof.ChapterPauliLorentz.spinorMap_preserves_mink
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz


open Matrix
open scoped BigOperators

theorem BookProof.ChapterPauliLorentz.spinorMap_preserves_mink (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1)
    (x : Fin 4 → ℝ) :
    mink (vecOfMat (Tᴴ * hermMat x * T)) = mink x := by sorry
