-- Generated from ChapterEulerCountableChain.lean — solution of BookProof.ChapterEulerCountableChain.stickProb_nonneg
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
import Theorems.Thm_BookProof_ChapterEulerCountableChain_stickTail_nonneg
open BookProof.ChapterEulerCountableChain



open scoped BigOperators
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (n : ℕ) :
    0 ≤ stickProb c n := mul_nonneg (stickTail_nonneg c hc n) (hc n).1
