-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.norm_crossB
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.norm_crossB (hκ : 0 ≤ κ) (X Y : ℕ → ℂ) (n : ℕ) :
    ‖crossB κ X Y n‖ = amp κ n * ‖X (n + 2)‖ * ‖Y n‖ := by sorry
