-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFockHam_sector
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (x : ymFockCore) (n : ℕ) :
    ((ymFockHam fabc x : ymFockSpace) : ∀ n : ℕ, L2d (n * 99)) n
      = ymSectorHam fabc n
        ⟨((x : ymFockSpace) : ∀ n : ℕ, L2d (n * 99)) n, x.2.2 n⟩ := rfl
