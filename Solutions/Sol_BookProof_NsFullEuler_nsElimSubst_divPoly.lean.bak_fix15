-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsElimSubst_divPoly
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
    nsElimHom k n (divPoly p) = liftParcel p (fourierDiv k) := by

  rw [divPoly, map_sum, fourierDiv, fourierMomentum, map_mul, liftParcel_C, map_sum,
    Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [nsElimHom_X_d, map_mul, liftParcel_C, liftParcel_X, ruIdx]
  ring
