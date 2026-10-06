-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.tsum_ampSeq_sq_le
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    (∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2)
      ≤ (1 / 8) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (κ ^ 2 / 2) * ‖(x : L2I ℕ)‖ ^ 2 := by

  refine le_trans (Summable.tsum_le_tsum (ampSeq_sq_le hκ x) (summable_ampSeq_sq hκ x)
    (hasSum_ampBound x).summable) ?_
  exact le_of_eq (hasSum_ampBound x).tsum_eq
