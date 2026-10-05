-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsRedFullFockHam_sector
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (x : nsRedFockCore) (n : ℕ) :
    ((nsRedFullFockHam nu k x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n
      = redHam nu k n
        ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.2 n⟩ := rfl
