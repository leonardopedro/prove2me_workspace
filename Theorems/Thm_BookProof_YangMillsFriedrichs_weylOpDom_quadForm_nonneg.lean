-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylOpDom_quadForm_nonneg
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.weylOpDom_quadForm_nonneg {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
    0 ≤ quadForm (weylOp pi Bf) x := by sorry
