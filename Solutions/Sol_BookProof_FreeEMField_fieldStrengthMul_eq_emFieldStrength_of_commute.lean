-- Generated from ChapterFreeEMField.lean — solution of BookProof.FreeEMField.fieldStrengthMul_eq_emFieldStrength_of_commute
import Mathlib
import Definitions.Def_ChapterFreeEMField
open BookProof.FreeEMField




open BookProof.YangMillsFieldStrength


variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution
    (δ : Fin 3 → R → R) (a : Fin 3 → R)
    (hcommute : ∀ j k, a j * a k = a k * a j) (j k : Fin 3) :
    fieldStrengthMul δ a j k = emFieldStrength δ a j k := by

  simp only [fieldStrengthMul, emFieldStrength, hcommute j k]; abel
