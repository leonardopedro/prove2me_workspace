-- Generated from ChapterEulerCountableChain.lean — solution of BookProof.ChapterEulerCountableChain.stickTail_nonneg
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain



open scoped BigOperators
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (N : ℕ) :
    0 ≤ stickTail c N := by

  apply Finset.prod_nonneg
  intro i _
  linarith [(hc i).2]
