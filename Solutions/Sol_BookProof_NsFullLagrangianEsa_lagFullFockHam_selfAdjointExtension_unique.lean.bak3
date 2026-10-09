-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.lagFullFockHam_selfAdjointExtension_unique
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_lagFullFockHam_esa
import Theorems.Thm_BookProof_EsaClosure_isSelfAdjointExtension_unique_of_esa
import Theorems.Thm_BookProof_NsFullLagrangian_lagFullOuterN_isPositiveSelfAdjointExtension
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ)
    {Dom : Submodule ℂ lagFockSpace} {A : Dom →ₗ[ℂ] lagFockSpace}
    (hA : IsSelfAdjointExtension (lagFullFockHam lam lam' mu gg) A) :
    Dom = (lagOuterComparison lam lam' mu gg).dom ∧
      ∀ (x : lagFockSpace) (h : x ∈ Dom) (h' : x ∈ (lagOuterComparison lam lam' mu gg).dom),
        A ⟨x, h⟩ = (lagOuterComparison lam lam' mu gg).op ⟨x, h'⟩ := by

  have hF := lagFullOuterN_isPositiveSelfAdjointExtension lam lam' mu gg
  exact isSelfAdjointExtension_unique_of_esa (lagFullFockHam_esa lam lam' mu gg) hA
    ⟨hF.1, hF.2.1, hF.2.2.2⟩
