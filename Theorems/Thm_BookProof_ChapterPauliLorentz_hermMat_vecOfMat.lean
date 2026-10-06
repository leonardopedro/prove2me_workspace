-- Generated from ChapterPauliLorentz.lean — theorem BookProof.ChapterPauliLorentz.hermMat_vecOfMat
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz


open Matrix
open scoped BigOperators

theorem BookProof.ChapterPauliLorentz.hermMat_vecOfMat {H : Matrix (Fin 2) (Fin 2) ℂ} (hH : Hᴴ = H) :
    hermMat (vecOfMat H) = H := by sorry
