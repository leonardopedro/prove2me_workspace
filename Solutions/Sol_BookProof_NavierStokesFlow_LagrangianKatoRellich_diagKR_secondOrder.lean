-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_secondOrder
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_add
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_real_smul
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
theorem solution :
    secondOrder diagKR = diagOp (fun n => (3 / 2 : ℝ) * (n : ℝ) ^ 2) := by

  simp only [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, diagKR,
    diagLagData, diagOp_comp, diagOp_sum, diagOp_real_smul, diagOp_add]
  show ((((1 / 2 : ℝ) : ℂ) • ∑ i, diagOp fun n => (n : ℝ) * (n : ℝ
