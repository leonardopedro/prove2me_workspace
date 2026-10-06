-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.tailSum_last
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.tailSum_last (p : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    tailSum p n (n - 1) = p (n - 1) := by sorry
