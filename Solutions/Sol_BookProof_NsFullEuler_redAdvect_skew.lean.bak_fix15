-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redAdvect_skew
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_coreRep_skewOn_op
import Theorems.Thm_BookProof_NsFullEuler_redAdvect_polySkew
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (m : Fin (n * 3))
    (x y : polyGaussCore (d := n * 6)) :
    inner ℂ (redAdvect k n m x) (y : L2d (n * 6))
      = -inner ℂ (x : L2d (n * 6)) (redAdvect k n m y) := coreRep_skewOn_op (coreRepPoly (n * 6)) (redAdvect_polySkew k n m) x y
