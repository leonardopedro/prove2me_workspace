-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullFockHam_sector
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) (x : nsFockCore) (n : ℕ) :
    ((nsFullFockHam nu lam mu gg x : nsFockSpace) : ∀ n : ℕ, L2d (n * 21)) n
      = nsSectorHam nu lam mu gg n
        ⟨((x : nsFockSpace) : ∀ n : ℕ, L2d (n * 21)) n, x.2.2 n⟩ := rfl
