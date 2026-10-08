-- Generated from ChapterYangMillsFieldStrength.lean — theorem BookProof.YangMillsFieldStrength.fieldStrengthMul_antisymm
import Mathlib
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength


open Complex



variable {R : Type*} [Ring R]


theorem BookProof.YangMillsFieldStrength.fieldStrengthMul_antisymm (δ : Fin 3 → R → R) (a : Fin 3 → R) (j k : Fin 3) :
    fieldStrengthMul δ a j k = - fieldStrengthMul δ a k j := by sorry
