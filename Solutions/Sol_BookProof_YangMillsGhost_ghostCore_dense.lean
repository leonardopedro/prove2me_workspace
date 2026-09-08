-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.ghostCore_dense
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.YangMillsGhost















noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((ghostCore K : Submodule ℂ (GhostSpace K)) : Set (GhostSpace K)) := dsCore_dense fun _ => polyGaussCore_dense
