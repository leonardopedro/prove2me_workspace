-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.oscSymbol_step
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.oscSymbol_step (n : ℕ) : oscSymbol κ (n + 2) = oscSymbol κ n + 4 * κ := by sorry
