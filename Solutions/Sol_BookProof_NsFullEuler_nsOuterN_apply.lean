-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsOuterN_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
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
theorem solution (nu lam mu gg : ℝ) (x : (nsOuterComparison nu lam mu gg).dom) (n : ℕ) :
    (((nsOuterComparison nu lam mu gg).op x : nsFockSpace) : ∀ n : ℕ, L2d (n * 21)) n
      = (nsFried nu lam mu gg n).op
          ⟨((x : nsFockSpace) : ∀ n : ℕ, L2d (n * 21)) n, x.2.1 n⟩ := dsCompOp_fib _ x n
