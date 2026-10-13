-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.nsFullFockHam_selfAdjointExtension_unique
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_nsFullFockHam_esa
import Theorems.Thm_BookProof_NsFullEuler_nsFullOuterN_isPositiveSelfAdjointExtension
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs

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
