-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.oscSymbol_step
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.oscSymbol_step (n : ℕ) : oscSymbol κ (n + 2) = oscSymbol κ n + 4 * κ := by sorry
