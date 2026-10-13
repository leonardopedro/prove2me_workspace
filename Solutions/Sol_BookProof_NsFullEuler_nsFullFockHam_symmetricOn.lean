-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullFockHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_symmetricOn
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
open BookProof.NsFullEuler




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
theorem solution (nu lam mu gg : ℝ) :
    SymmetricOn nsFockCore (nsFullFockHam nu lam mu gg) := dsOp_symmetricOn _ fun n => nsSectorHam_symmetricOn nu lam mu gg n
