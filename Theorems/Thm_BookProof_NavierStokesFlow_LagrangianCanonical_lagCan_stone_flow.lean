-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_stone_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical
















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

open BookProof.ChapterStoneResolvent BookProof.StoneBridge BookProof.EsaClosure in
theorem BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_stone_flow (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (U : ℝ → (L2I Vel →L[ℂ] L2I Vel)),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) T.op ∧ IsStoneFlow T U := by sorry
