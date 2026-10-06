-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.oscSymbol_step
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : oscSymbol κ (n + 2) = oscSymbol κ n + 4 * κ := by

  simp only [oscSymbol]
  push_cast
  ring
