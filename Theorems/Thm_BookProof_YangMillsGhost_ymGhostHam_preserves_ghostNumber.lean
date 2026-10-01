-- Generated from ChapterYangMillsGhostSector.lean — theorem BookProof.YangMillsGhost.ymGhostHam_preserves_ghostNumber
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.YangMillsGhost

variable {K : ℕ}



noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.ChapterStoneResolvent


theorem BookProof.YangMillsGhost.ymGhostHam_preserves_ghostNumber (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (n : ℕ) (x : ghostCore K)
    (hx : ∀ S : GConf K, ghostNum S ≠ n → (x : GhostSpace K) S = 0) :
    ∀ S : GConf K, ghostNum S ≠ n →
      ((ymGhostHam fabc ω x : GhostSpace K) : ∀ _ : GConf K, L2d 99) S = 0 := by sorry
