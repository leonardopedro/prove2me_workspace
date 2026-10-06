-- Generated from ChapterE2.lean — theorem BookProof.ChapterE2.stick_eq
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2


open scoped BigOperators
open Finset

theorem BookProof.ChapterE2.stick_eq (θ : ℕ → ℝ) (n : ℕ) :
    stick θ n = remainder θ n * Real.cos (θ n) ^ 2 := by sorry
