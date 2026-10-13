-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFullFockHam_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_QgOuterFock_dsOp_quadForm_nonneg
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) (x : lagFockCore) :
    0 ≤ quadForm (lagFullFockHam lam lam' mu gg) x := dsOp_quadForm_nonneg _ (fun n u => lagSectorHam_quadForm_nonneg lam lam' mu gg n u) x
