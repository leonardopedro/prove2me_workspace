-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.bosOp_even
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_bosOp_ghostOp_comm
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (A : BoseAlg →ₗ[ℂ] BoseAlg) (z : QGGraded) :
    qgGrade (bosOp A z) = bosOp A (qgGrade z) := (bosOp_ghostOp_comm A fermGrade z).symm
