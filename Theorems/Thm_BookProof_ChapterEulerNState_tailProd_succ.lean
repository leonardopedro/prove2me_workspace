-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.tailProd_succ
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.tailProd_succ (θ : ℕ → ℝ) (m : ℕ) :
    tailProd θ (m + 1) = tailProd θ m * Real.sin (θ m) ^ 2 := by sorry
