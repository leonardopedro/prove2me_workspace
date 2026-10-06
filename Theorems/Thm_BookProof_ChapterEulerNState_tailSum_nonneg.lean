-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.tailSum_nonneg
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.tailSum_nonneg (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) (n k : ℕ) :
    0 ≤ tailSum p n k := by sorry
