-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.nsSectorHam_esa
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Theorems.Thm_BookProof_NsFullLagrangianEsa_eulIdx_injective
import Theorems.Thm_BookProof_NsFullLagrangianEsa_nsSectorHam_eq_weylPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_esa
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 21))
      (NsFullEuler.nsSectorHam nu lam mu gg n) := by

  rw [nsSectorHam_eq_weylPoly]
  exact weylPoly_esa (eulIdx_injective n) fun m => NsFullEuler.realCoeff_nsFormOf _ _ _ _ _ _
