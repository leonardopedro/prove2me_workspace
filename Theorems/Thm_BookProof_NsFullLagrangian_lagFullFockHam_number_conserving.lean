-- Generated from ChapterNavierStokesFullLagrangianFock.lean — theorem BookProof.NsFullLagrangian.lagFullFockHam_number_conserving
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
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.NsFullLagrangian.lagFullFockHam_number_conserving (lam lam' mu gg : ℝ) (x : lagFockCore) {n : ℕ}
    (hx : ∀ m, m ≠ n → ((x : lagFockSpace) : ∀ m : ℕ, L2d (m * 36)) m = 0) (m : ℕ) (hm : m ≠ n) :
    ((lagFullFockHam lam lam' mu gg x : lagFockSpace) : ∀ m : ℕ, L2d (m * 36)) m = 0 := by sorry
