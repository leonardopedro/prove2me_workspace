-- Generated from ChapterNsFullLagrangianFockEsa.lean — theorem BookProof.NsFullLagrangianEsa.nsFullFockHam_selfAdjointExtension_unique
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.NsFullLagrangianEsa



open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

theorem BookProof.NsFullLagrangianEsa.nsFullFockHam_selfAdjointExtension_unique (nu lam mu gg : ℝ)
    {Dom : Submodule ℂ NsFullEuler.nsFockSpace} {A : Dom →ₗ[ℂ] NsFullEuler.nsFockSpace}
    (hA : IsSelfAdjointExtension (NsFullEuler.nsFullFockHam nu lam mu gg) A) :
    Dom = (NsFullEuler.nsOuterComparison nu lam mu gg).dom ∧
      ∀ (x : NsFullEuler.nsFockSpace) (h : x ∈ Dom)
        (h' : x ∈ (NsFullEuler.nsOuterComparison nu lam mu gg).dom),
        A ⟨x, h⟩ = (NsFullEuler.nsOuterComparison nu lam mu gg).op ⟨x, h'⟩ := by sorry
