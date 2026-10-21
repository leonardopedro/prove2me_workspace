-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redVisc_eq_liftParcel
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    redVisc nu k n p i = liftParcel p (fourierVisc nu k i) := by

  simp only [redVisc, fourierVisc, map_add, map_mul, liftParcel_C, liftParcel_X, rqIdx, ruIdx]
