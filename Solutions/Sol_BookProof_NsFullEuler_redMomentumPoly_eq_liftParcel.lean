-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redMomentumPoly_eq_liftParcel
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
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    redMomentumPoly k n p = liftParcel p (fourierMomentum k) := by

  rw [redMomentumPoly, fourierMomentum, map_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [map_mul, liftParcel_C, liftParcel_X, ruIdx]
