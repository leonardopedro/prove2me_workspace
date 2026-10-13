-- Generated from ChapterNsFullLagrangianFockEsa.lean — solution of BookProof.NsFullLagrangianEsa.realCoeff_lagForms
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.NsFullLagrangianEsa




open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) (n : ℕ) (m : Fin (n * 28)) :
    RealCoeff (lagForms lam lam' mu gg n m) := realCoeff_lagFormOf _ _ _ _ _ _
