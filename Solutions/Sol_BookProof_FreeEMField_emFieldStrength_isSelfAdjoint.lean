-- Generated from ChapterFreeEMField.lean — solution of BookProof.FreeEMField.emFieldStrength_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterFreeEMField
open BookProof.FreeEMField




open BookProof.YangMillsFieldStrength


variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]
variable {R : Type*} [Ring R] [Algebra ℂ R]
variable {R : Type*} [Ring R] [StarRing R]

set_option maxHeartbeats 1000000 in
theorem solution
    (δ : Fin 3 → R → R) (π : Fin 3 → R)
    (hstar : ∀ (j : Fin 3) x, star (δ j x) = δ j (star x))
    (hsa : ∀ i, IsSelfAdjoint (π i)) (j k : Fin 3) :
    IsSelfAdjoint (emFieldStrength δ π j k) := by

  change star (δ j (π k) - δ k (π j)) = δ j (π k) - δ k (π j)
  rw [star_sub, hstar, hstar, (hsa k).star_eq, (hsa j).star_eq]
