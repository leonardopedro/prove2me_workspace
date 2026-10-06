-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.euler_sum_one
import Mathlib
import Definitions.Def_ChapterEulerNState
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.euler_sum_one (θ : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    ∑ k ∈ Finset.range n, bornProb θ n k = 1 := by sorry
