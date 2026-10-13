-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.ghostCore_dense
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Theorems.Thm_BookProof_DirectSumEsa_dsCore_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
open BookProof.YangMillsGhost




noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

variable {K : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((ghostCore K : Submodule ℂ (GhostSpace K)) : Set (GhostSpace K)) := dsCore_dense fun _ => polyGaussCore_dense
