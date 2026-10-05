-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgGhostCar
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_car_fermAnn_fermCre
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
    ghostOp (fermAnn j) (ghostOp (fermCre j) z) + ghostOp (fermCre j) (ghostOp (fermAnn j) z)
      = z := by

  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
      simp only [ghostOp_tmul]
      rw [← TensorProduct.tmul_add, car_fermAnn_fermCre]
  | add z w hz hw =>
      simp only [map_add]
      rw [show ghostOp (fermAnn j) (ghostOp (fermCre j) z)
              + ghostOp (fermAnn j) (ghostOp (fermCre j) w)
            + (ghostOp (fermCre j) (ghostOp (fermAnn j) z)
              + ghostOp (fermCre j) (ghostOp (fermAnn j) w))
          = (ghostOp (fermAnn j) (ghostOp (fermCre j) z)
              + ghostOp (fermCre j) (ghostOp (fermAnn j) z))
            + (ghostOp (fermAnn j) (ghostOp (fermCre j) w)
              + ghostOp (fermCre j) (ghostOp (fermAnn j) w)) by abel,
        hz, hw]
