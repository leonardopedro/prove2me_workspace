-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.tailSum_zero_eq
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.tailSum_zero_eq (p : ℕ → ℝ) (n : ℕ) :
    tailSum p n 0 = ∑ j ∈ Finset.range n, p j := by sorry
