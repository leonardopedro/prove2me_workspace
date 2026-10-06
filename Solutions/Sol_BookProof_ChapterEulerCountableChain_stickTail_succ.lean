-- Generated from ChapterEulerCountableChain.lean — solution of BookProof.ChapterEulerCountableChain.stickTail_succ
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain



open scoped BigOperators
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (N : ℕ) :
    stickTail c (N + 1) = stickTail c N * (1 - c N) := by

  simp [stickTail, Finset.prod_range_succ]
