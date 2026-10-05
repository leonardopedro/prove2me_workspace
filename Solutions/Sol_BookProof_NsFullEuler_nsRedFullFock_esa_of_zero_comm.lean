-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsRedFullFock_esa_of_zero_comm
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_nsRedFullFock_esa_of_commBound
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ)
    (H : (nsRedOuterComparison nu k).dom →ₗ[ℂ] nsRedFockSpace)
    (hH : SymmetricOn (nsRedOuterComparison nu k).dom H)
    (hcomm : ∀ x : (nsRedOuterComparison nu k).dom,
      commForm H (nsRedOuterComparison nu k).op x = 0) :
    EssentiallySelfAdjointOn (nsRedOuterComparison nu k).dom H := nsRedFullFock_esa_of_commBound nu k H hH le_rfl fun x => by rw [hcomm x]; simp
