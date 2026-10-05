-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redFieldN_div
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    redFieldN nu k n (finProdFinEquiv (p, divIdx7))
      = (coreRepPoly (n * 6)).op (mulOp (redMomentumPoly k n p)) := by

  simp only [redFieldN, Equiv.symm_apply_apply, redFormPoly_div]
