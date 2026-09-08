-- Generated from ChapterYangMillsGhostSector.lean — theorem BookProof.YangMillsGhost.ymGhostHam_stone_flow
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.YangMillsGhost














noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

theorem BookProof.YangMillsGhost.ymGhostHam_stone_flow (ω : Fin K → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (GhostSpace K)) (U : ℝ → (GhostSpace K →L[ℂ] GhostSpace K)),
      IsSelfAdjointExtension (ymGhostHam 0 ω) T.op ∧ IsStoneFlow T U := by sorry
