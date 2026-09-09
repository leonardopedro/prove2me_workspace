-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_secondOrder
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

















open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)


























variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)








open LpNat DiagonalEsa

set_option maxHeartbeats 1000000 in
theorem solution :
    secondOrder diagKR = diagOp (fun n => (3 / 2 : ℝ) * (n : ℝ) ^ 2) := by

  simp only [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, diagKR,
    diagLagData, diagOp_comp, diagOp_sum, diagOp_real_smul, diagOp_add]
  refine congrArg diagOp ?_
  funext n
  simp only [Fin.sum_univ_three]
  ring
