-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsElimSubst_advect
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
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    nsElimHom k n (∑ j : Fin 3, X (ycoord p (uIdx j)) * X (ycoord p (dIdx i j)))
      = C Complex.I * liftParcel p (fourierAdvect k i) := by

  simp only [nsElimHom_X, ycoord, Equiv.symm_apply_apply, nsElimCoord_uIdx, nsElimCoord_dIdx,
    fourierAdvect, fourierMomentum, map_sum, map_mul, liftParcel_C, liftParcel_X]
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  ring
