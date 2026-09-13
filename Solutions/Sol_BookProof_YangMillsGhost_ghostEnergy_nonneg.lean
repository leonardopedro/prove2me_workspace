-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.ghostEnergy_nonneg
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
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
theorem solution {ω : Fin K → ℝ} (hω : ∀ p, 0 ≤ ω p) (S : GConf K) :
    0 ≤ ghostEnergy ω S := Finset.sum_nonneg fun p _ => hω p
