-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_secondOrder_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_secondOrder
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
theorem solution :
    HasZeroDeficiencyOn diagKR.D (secondOrder diagKR) := by

  rw [diagKR_secondOrder]
  exact diagOp_hasZeroDeficiencyOn _
