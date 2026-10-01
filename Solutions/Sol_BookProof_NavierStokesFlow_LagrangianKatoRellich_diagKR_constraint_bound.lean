-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_constraint_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
 => (n : ℝ)) = diagOp fun n => 3 * (n : ℝ)
  simp only [diagOp_real_smul, diagOp_sum]
  refine cong :=
  rArg diagOp ?_
    funext n
    simp only [Fin.sum_univ_three]
    ring
  
  t
