-- Generated from ChapterPauliLorentz.lean — theorem BookProof.ChapterPauliLorentz.hermMat_eq_pauli
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz


open Matrix
open scoped BigOperators

theorem BookProof.ChapterPauliLorentz.hermMat_eq_pauli (x : Fin 4 → ℝ) :
    hermMat x = (x 0 : ℂ) • σ0 + (x 1 : ℂ) • σ1 + (x 2 : ℂ) • σ2 + (x 3 : ℂ) • σ3 := by sorry
