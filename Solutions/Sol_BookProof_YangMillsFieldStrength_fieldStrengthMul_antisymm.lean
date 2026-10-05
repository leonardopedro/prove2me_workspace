-- Generated from ChapterYangMillsFieldStrength.lean — solution of BookProof.YangMillsFieldStrength.fieldStrengthMul_antisymm
import Mathlib
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength



open Complex



variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (δ : Fin 3 → R → R) (a : Fin 3 → R) (j k : Fin 3) :
    fieldStrengthMul δ a j k = - fieldStrengthMul δ a k j := by

  simp only [fieldStrengthMul]; noncomm_ring
