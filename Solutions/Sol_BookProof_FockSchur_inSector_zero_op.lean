-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.inSector_zero_op
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : InSector n (0 : FockAlg) := by

  intro α hα; simp at hα
