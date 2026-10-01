-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — theorem BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampOcc_le
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampOcc_le (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    (∑' n, amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2)
      ≤ (1 / 4 + κ / 2) * quadForm (diagMax (oscSymbol κ)) x := by sorry
