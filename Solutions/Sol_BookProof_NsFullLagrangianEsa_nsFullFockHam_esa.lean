-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.nsFullFockHam_esa
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_nsSectorHam_esa
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    EssentiallySelfAdjointOn NsFullEuler.nsFockCore (NsFullEuler.nsFullFockHam nu lam mu gg) := dsOp_essentiallySelfAdjointOn _ fun n => nsSectorHam_esa nu lam mu gg n
