-- Generated from ChapterFreeEMField.lean — theorem BookProof.FreeEMField.emFieldStrength_isSelfAdjoint
import Definitions.Def_ChapterYangMillsFieldStrength
import Mathlib
import Definitions.Def_ChapterFreeEMField
open BookProof.FreeEMField

variable {R : Type*} [Ring R]
variable {R : Type*} [Ring R] [Algebra ℂ R]
variable {R : Type*} [Ring R] [StarRing R]



open BookProof.YangMillsFieldStrength



theorem BookProof.FreeEMField.emFieldStrength_isSelfAdjoint
    (δ : Fin 3 → R → R) (π : Fin 3 → R)
    (hstar : ∀ (j : Fin 3) x, star (δ j x) = δ j (star x))
    (hsa : ∀ i, IsSelfAdjoint (π i)) (j k : Fin 3) :
    IsSelfAdjoint (emFieldStrength δ π j k) := by sorry
