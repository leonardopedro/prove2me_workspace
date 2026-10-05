-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgCCR
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_FockSecondQuantization_ccr_annA_creA
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (z : QGGraded) :
    bosOp (annA j) (bosOp (creA j) z) - bosOp (creA j) (bosOp (annA j) z) = z := by

  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
      simp only [bosOp_tmul]
      rw [← TensorProduct.sub_tmul, ccr_annA_creA]
  | add z w hz hw =>
      simp only [map_add]
      rw [show bosOp (annA j) (bosOp (creA j) z) + bosOp (annA j) (bosOp (creA j) w)
            - (bosOp (creA j) (bosOp (annA j) z) + bosOp (creA j) (bosOp (annA j) w))
          = (bosOp (annA j) (bosOp (creA j) z) - bosOp (creA j) (bosOp (annA j) z))
            + (bosOp (annA j) (bosOp (creA j) w) - bosOp (creA j) (bosOp (annA j) w)) by abel,
        hz, hw]
