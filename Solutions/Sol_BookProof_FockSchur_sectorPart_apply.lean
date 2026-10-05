-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.sectorPart_apply
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
theorem solution (n : ℕ) (u : FockAlg) (α : Conf) :
    sectorPart n u α = if ndeg α = n then u α else 0 := by

  classical
  simp [sectorPart, Finsupp.filter_apply]
