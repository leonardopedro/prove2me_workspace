-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redAdvect_polySkew
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_mulOp_polySkew
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (m : Fin (n * 3)) :
    PolySkew (mulOp
      (C Complex.I * redAdvectPoly k n (finProdFinEquiv.symm m).1 (finProdFinEquiv.symm m).2)) := mulOp_polySkew (realCoeff_redAdvectPoly k n _ _)
