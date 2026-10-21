-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redFieldN_re
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
    redFieldN nu k n (finProdFinEquiv (p, reIdx7 i))
      = (coreRepPoly (n * 6)).op (mulOp (redVisc nu k n p i)) := by

  simp only [redFieldN, Equiv.symm_apply_apply, redFormPoly_re]
