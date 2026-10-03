-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.weyl_friedrichs_bounded
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Theorems.Thm_BookProof_YangMillsFriedrichsLimit_sirk_limit_eq_positive_selfadjoint_extension
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn
open BookProof.YangMillsFriedrichsLimit




open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
/
theorem solution [CompleteSpace F] {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ := by

  obtain ⟨A, hagree, hext, hlim⟩ :=
    sirk_limit_eq_positive_selfadjoint_extension (weylOp pi Bf) hdense
      (weylOpDom_symmetricOn hpi hB) (weylOpDom_quadForm_nonneg hpi hB) C hbd v
  exact ⟨A, hagree, hext, fun hcyc => (hlim hcyc).1⟩
