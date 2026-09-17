-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.hFull_eq_add
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
theorem solution : L.hFull = secondOrder L + lowOrder L := by

  simp only [LagrangianFullData.hFull, secondOrder, lowOrder]
  abel
