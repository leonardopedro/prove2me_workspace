-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.superBracket_bosOp_ghostOp
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_superBracket_even_odd
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
theorem solution (A : BoseAlg →ₗ[ℂ] BoseAlg) (B : FermAlg →ₗ[ℂ] FermAlg) :
    superBracket 0 1 (bosOp A) (ghostOp B) = 0 := by

  refine LinearMap.ext fun z => ?_
  rw [superBracket_even_odd, bosOp_ghostOp_comm, sub_self]
  rfl
