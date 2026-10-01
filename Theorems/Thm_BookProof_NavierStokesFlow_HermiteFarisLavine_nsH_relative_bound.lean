-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.nsH_relative_bound (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    ‖(nsH κ hκ x : L2I ℕ)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (2 * κ ^ 2) * ‖(x : L2I ℕ)‖ ^ 2 := by sorry
