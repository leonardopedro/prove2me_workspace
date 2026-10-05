-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.balanced_xIdx
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {p q : ι} (h : ω p = ω q) : Balanced ω (xIdx q) (xIdx p) := by

  simp [Balanced, h]
