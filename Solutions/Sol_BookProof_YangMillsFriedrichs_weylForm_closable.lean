-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.weylForm_closable
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_form_closable
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}





















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : ℕ → D)
    (hCauchy : ∀ ε > 0, ∃ N : ℕ, ∀ p ≥ N, ∀ q ≥ N, formNormSq (weylOp pi Bf) (x p - x q) < ε)
    (hzero : Filter.Tendsto (fun k => ((x k : F))) Filter.atTop (nhds 0)) :
    Filter.Tendsto (fun k => formNormSq (weylOp pi Bf) (x k)) Filter.atTop (nhds 0) := form_closable (weylOpDom_symmetricOn hpi hB) (weylOpDom_quadForm_nonneg hpi hB) x hCauchy hzero
