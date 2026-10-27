-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.ghostOp_odd_ann
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_fermGrade_fermAnn
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
    qgGrade (ghostOp (fermAnn j) z) = - ghostOp (fermAnn j) (qgGrade z) := by

  induction z using TensorProduct.induction_on with
  | zero => simp [qgGrade]
  | tmul x y =>
      simp only [qgGrade, ghostOp_tmul, fermGrade_fermAnn]
      rw [TensorProduct.tmul_neg]
  | add z w hz hw =>
      simp only [map_add, hz, hw]
      abel
