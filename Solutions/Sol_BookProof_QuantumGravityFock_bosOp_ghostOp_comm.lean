-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.bosOp_ghostOp_comm
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (A : BoseAlg →ₗ[ℂ] BoseAlg) (B : FermAlg →ₗ[ℂ] FermAlg)
    (z : QGGraded) : bosOp A (ghostOp B z) = ghostOp B (bosOp A z) := by

  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y => simp
  | add z w hz hw => simp [map_add, hz, hw]
