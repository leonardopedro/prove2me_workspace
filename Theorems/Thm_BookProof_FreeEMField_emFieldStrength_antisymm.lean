-- Generated from ChapterFreeEMField.lean — theorem BookProof.FreeEMField.emFieldStrength_antisymm
import Definitions.Def_ChapterYangMillsFieldStrength
import Mathlib
import Definitions.Def_ChapterFreeEMField
open BookProof.FreeEMField



open BookProof.YangMillsFieldStrength


variable {R : Type*} [Ring R]


theorem BookProof.FreeEMField.emFieldStrength_antisymm (δ : Fin 3 → R → R) (A : Fin 3 → R) (j k : Fin 3) :
    emFieldStrength δ A j k = - emFieldStrength δ A k j := by sorry
