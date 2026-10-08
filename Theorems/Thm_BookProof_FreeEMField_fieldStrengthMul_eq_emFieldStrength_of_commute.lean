-- Generated from ChapterFreeEMField.lean — theorem BookProof.FreeEMField.fieldStrengthMul_eq_emFieldStrength_of_commute
import Mathlib
import Definitions.Def_ChapterFreeEMField
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength
open BookProof.FreeEMField



open BookProof.YangMillsFieldStrength


variable {R : Type*} [Ring R]


theorem BookProof.FreeEMField.fieldStrengthMul_eq_emFieldStrength_of_commute
    (δ : Fin 3 → R → R) (a : Fin 3 → R)
    (hcommute : ∀ j k, a j * a k = a k * a j) (j k : Fin 3) :
    fieldStrengthMul δ a j k = emFieldStrength δ a j k := by sorry
