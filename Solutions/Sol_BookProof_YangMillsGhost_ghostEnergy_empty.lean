-- Generated from ChapterYangMillsGhostSector.lean — solution of BookProof.YangMillsGhost.ghostEnergy_empty
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
theorem solution (ω : Fin K → ℝ) : ghostEnergy ω (∅ : GConf K) = 0 := by

  simp [ghostEnergy]
