-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.euler_reproduces
import Mathlib
import Definitions.Def_ChapterEulerNState
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.euler_reproduces (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) {n : ℕ} (hn : 1 ≤ n)
    (hsum : ∑ j ∈ Finset.range n, p j = 1) :
    ∃ θ : ℕ → ℝ, ∀ k < n, bornProb θ n k = p k := by sorry
