-- Generated from ChapterFreeEMField.lean — theorem BookProof.FreeEMField.emFieldStrength_gauge_invariant
import Definitions.Def_ChapterYangMillsFieldStrength
import Mathlib
import Definitions.Def_ChapterFreeEMField
open BookProof.FreeEMField

variable {R : Type*} [Ring R]



open BookProof.YangMillsFieldStrength



theorem BookProof.FreeEMField.emFieldStrength_gauge_invariant
    (δ : Fin 3 → R → R) (A : Fin 3 → R) (θ : R)
    (hadd : ∀ j x y, δ j (x + y) = δ j x + δ j y)
    (hcomm : ∀ j k x, δ j (δ k x) = δ k (δ j x))
    (j k : Fin 3) :
    emFieldStrength δ (fun i => A i + δ i θ) j k = emFieldStrength δ A j k := by sorry
