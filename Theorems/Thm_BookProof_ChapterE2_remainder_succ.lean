-- Generated from ChapterE2.lean — theorem BookProof.ChapterE2.remainder_succ
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2


open scoped BigOperators
open Finset

theorem BookProof.ChapterE2.remainder_succ (θ : ℕ → ℝ) (N : ℕ) :
    remainder θ (N + 1) = remainder θ N * Real.sin (θ N) ^ 2 := by sorry
