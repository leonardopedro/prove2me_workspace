-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgGhostCar_of_ne
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_car_fermAnn_fermCre_of_ne
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {j k : ℕ} (h : j ≠ k) (z : QGGraded) :
    ghostOp (fermAnn j) (ghostOp (fermCre k) z) + ghostOp (fermCre k) (ghostOp (fermAnn j) z)
      = 0 := by

  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
      simp only [ghostOp_tmul]
      rw [← TensorProduct.tmul_add, car_fermAnn_fermCre_of_ne h, TensorProduct.tmul_zero]
  | add z w hz hw =>
      simp only [map_add]
      rw [show ghostOp (fermAnn j) (ghostOp (fermCre k) z)
              + ghostOp (fermAnn j) (ghostOp (fermCre k) w)
            + (ghostOp (fermCre k) (ghostOp (fermAnn j) z)
              + ghostOp (fermCre k) (ghostOp (fermAnn j) w))
          = (ghostOp (fermAnn j) (ghostOp (fermCre k) z)
              + ghostOp (fermCre k) (ghostOp (fermAnn j) z))
            + (ghostOp (fermAnn j) (ghostOp (fermCre k) w)
              + ghostOp (fermCre k) (ghostOp (fermAnn j) w)) by abel,
        hz, hw, add_zero]
