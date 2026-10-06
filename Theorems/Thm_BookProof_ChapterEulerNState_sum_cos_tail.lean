-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.sum_cos_tail
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.sum_cos_tail (θ : ℕ → ℝ) (m : ℕ) :
    ∑ k ∈ Finset.range m, tailProd θ k * Real.cos (θ k) ^ 2
      = 1 - tailProd θ m := by sorry
