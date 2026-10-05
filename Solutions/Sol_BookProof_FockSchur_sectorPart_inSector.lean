-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.sectorPart_inSector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (u : FockAlg) : InSector n (sectorPart n u) := by

  classical
  intro α hα
  rw [sectorPart, Finsupp.support_filter] at hα
  exact (Finset.mem_filter.mp hα).2
