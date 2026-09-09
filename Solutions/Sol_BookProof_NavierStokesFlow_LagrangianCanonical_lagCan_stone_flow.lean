-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_stone_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_lagCan_esa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
open BookProof.ChapterStoneResolvent BookProof.StoneBridge BookProof.EsaClosure in
theorem solution (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (U : ℝ → (L2I Vel →L[ℂ] L2I Vel)),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (lagrangianCore (lagCanData nu hnu f)) (lagCanData nu hnu f).dense
      (lagrangianCore_symmetricOn (lagCanData nu hnu f)) (lagCan_esa nu hnu f)
