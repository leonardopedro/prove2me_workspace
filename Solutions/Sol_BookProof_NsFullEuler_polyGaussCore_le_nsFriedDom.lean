-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.polyGaussCore_le_nsFriedDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) (n : ℕ) :
    (polyGaussCore (d := n * 21)) ≤ (nsFried nu lam mu gg n).dom :=
  fun v hv =>
    (friedrichsComparison_extends (nsPosSym nu lam mu gg n) polyGaussCore_dense ⟨v, hv⟩).choose
