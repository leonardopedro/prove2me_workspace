-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.ymGhostHam_add_bounded_coupling_esa
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Theorems.Thm_BookProof_YangMillsGhost_ymGhostHam_symmetricOn
import Theorems.Thm_BookProof_YangMillsGhost_ymGhostHam_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_KatoRellich_essentiallySelfAdjointOn_add_bounded
open BookProof.YangMillsGhost




noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

variable {K : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ω : Fin K → :=
  essentiallySelfAdjointOn_add_bounded _ (ymGhostHam_symmetricOn 0 ω)
      (ymGhostHam_essentiallySelfAdjointOn_core ω) B hB
