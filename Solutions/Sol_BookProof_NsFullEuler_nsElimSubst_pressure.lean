-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsElimSubst_pressure
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
    nsElimHom k n (X (ycoord p (qIdx i))) = liftParcel p (X (rqIdx6 i)) := by

  rw [nsElimHom_X_q, liftParcel_X, rqIdx]
