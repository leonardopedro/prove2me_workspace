-- Generated from ChapterPauliLorentz.lean — theorem BookProof.ChapterPauliLorentz.hermMat_injective
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz


open Matrix
open scoped BigOperators

theorem BookProof.ChapterPauliLorentz.hermMat_injective {x y : Fin 4 → ℝ} (h : hermMat x = hermMat y) :
    x 0 = y 0 ∧ x 1 = y 1 ∧ x 2 = y 2 ∧ x 3 = y 3 := by sorry
