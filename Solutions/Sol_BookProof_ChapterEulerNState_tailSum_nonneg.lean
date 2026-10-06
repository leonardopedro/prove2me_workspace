-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.tailSum_nonneg
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) (n k : ℕ) :
    0 ≤ tailSum p n k := Finset.sum_nonneg fun j _ => hp j
