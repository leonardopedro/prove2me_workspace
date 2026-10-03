-- Generated from ChapterYangMillsGhostSector.lean — theorem BookProof.YangMillsGhost.ymGhostHam_vacuum_fibre
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.YangMillsGhost

variable {K : ℕ}



noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.ChapterStoneResolvent


theorem BookProof.YangMillsGhost.ymGhostHam_vacuum_fibre (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (x : ghostCore K) :
    ((ymGhostHam fabc ω x : GhostSpace K) : ∀ _ : GConf K, L2d 99) ∅
      = ymHamiltonian (coreRepPoly 99) fabc ⟨(x : GhostSpace K) ∅, x.2.2 ∅⟩ := by sorry
