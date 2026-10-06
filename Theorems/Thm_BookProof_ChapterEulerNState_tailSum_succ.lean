-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.tailSum_succ
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.tailSum_succ (p : ℕ → ℝ) (n k : ℕ) (h : k < n) :
    tailSum p n k = p k + tailSum p n (k + 1) := by sorry
