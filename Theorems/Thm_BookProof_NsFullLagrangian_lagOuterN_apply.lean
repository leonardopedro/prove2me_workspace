-- Generated from ChapterNavierStokesFullLagrangianFock.lean — theorem BookProof.NsFullLagrangian.lagOuterN_apply
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL
open BookProof.NsFullLagrangian

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.NsFullLagrangian.lagOuterN_apply (lam lam' mu gg : ℝ) (x : (lagOuterComparison lam lam' mu gg).dom)
    (n : ℕ) :
    (((lagOuterComparison lam lam' mu gg).op x : lagFockSpace) : ∀ n : ℕ, L2d (n * 36)) n
      = (lagFried lam lam' mu gg n).op
          ⟨((x : lagFockSpace) : ∀ n : ℕ, L2d (n * 36)) n, x.2.1 n⟩ := by sorry
