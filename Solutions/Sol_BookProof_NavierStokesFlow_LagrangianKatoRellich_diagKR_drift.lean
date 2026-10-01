-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_drift
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_real_smul
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in

      + (((0 : ℝ) : ℂ) • ∑ i, diagOp fun n => (0 : ℝ) * (0 :=
  : ℝ)))
        = diagOp fun n => (3 / 2 : ℝ) * (n : ℝ) ^ 2
    simp only [diagOp_sum, diagOp_real_smul, diagOp_add]
    refine congrArg diagOp ?_
    funext n
    simp only [Fin.
