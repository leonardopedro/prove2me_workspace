-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.stickTail_succ
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.stickTail_succ (c : ℕ → ℝ) (N : ℕ) :
    stickTail c (N + 1) = stickTail c N * (1 - c N) := by sorry
