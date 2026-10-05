-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.numSym_nonneg
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (α : Conf) : 0 ≤ numSym α := by

  have : (0:ℝ) ≤ (ndeg α : ℝ) := Nat.cast_nonneg _
  simp only [numSym]; linarith
