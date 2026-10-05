-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.nsFullFockHam_selfAdjointExtension_unique
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_nsFullFockHam_esa
import Theorems.Thm_BookProof_EsaClosure_isSelfAdjointExtension_unique_of_esa
import Theorems.Thm_BookProof_NsFullEuler_nsFullOuterN_isPositiveSelfAdjointExtension
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ)
    {Dom : Submodule ℂ NsFullEuler.nsFockSpace} {A : Dom →ₗ[ℂ] NsFullEuler.nsFockSpace}
    (hA : IsSelfAdjointExtension (NsFullEuler.nsFullFockHam nu lam mu gg) A) :
    Dom = (NsFullEuler.nsOuterComparison nu lam mu gg).dom ∧
      ∀ (x : NsFullEuler.nsFockSpace) (h : x ∈ Dom)
        (h' : x ∈ (NsFullEuler.nsOuterComparison nu lam mu gg).dom),
        A ⟨x, h⟩ = (NsFullEuler.nsOuterComparison nu lam mu gg).op ⟨x, h'⟩ := by

  have hF := NsFullEuler.nsFullOuterN_isPositiveSelfAdjointExtension nu lam mu gg
  exact isSelfAdjointExtension_unique_of_esa (nsFullFockHam_esa nu lam mu gg) hA
    ⟨hF.1, hF.2.1, hF.2.2.2⟩
