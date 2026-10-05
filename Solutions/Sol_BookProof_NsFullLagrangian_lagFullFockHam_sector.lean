-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFullFockHam_sector
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) (x : lagFockCore) (n : ℕ) :
    ((lagFullFockHam lam lam' mu gg x : lagFockSpace) : ∀ n : ℕ, L2d (n * 36)) n
      = lagSectorHam lam lam' mu gg n
        ⟨((x : lagFockSpace) : ∀ n : ℕ, L2d (n * 36)) n, x.2.2 n⟩ := rfl
