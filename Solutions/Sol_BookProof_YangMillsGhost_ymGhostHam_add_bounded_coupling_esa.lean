-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.ymGhostHam_add_bounded_coupling_esa
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Theorems.Thm_BookProof_YangMillsGhost_ymGhostHam_symmetricOn
import Theorems.Thm_BookProof_YangMillsGhost_ymGhostHam_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
open BookProof.YangMillsGhost















noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ω : Fin K → ℝ)
    (B : GhostSpace K →L[ℂ] GhostSpace K)
    (hB : ∀ x y : GhostSpace K, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn (ghostCore K)
      (ymGhostHam 0 ω + (B.toLinearMap ∘ₗ (ghostCore K).subtype)) :=
  essentiallySelfAdjointOn_add_bounded _ (ymGhostHam_symmetricOn 0 ω)
      (ymGhostHam_essentiallySelfAdjointOn_core ω) B hB
