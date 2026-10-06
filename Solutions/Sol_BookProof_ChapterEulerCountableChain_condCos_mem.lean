-- Generated from ChapterEulerCountableChain.lean — solution of BookProof.ChapterEulerCountableChain.condCos_mem
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain



open scoped BigOperators
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (n : ℕ) : 0 ≤ condCos θ n ∧ condCos θ n ≤ 1 := by

  refine ⟨sq_nonneg _, ?_⟩
  rw [condCos]
  nlinarith [Real.sin_sq_add_cos_sq (θ n), sq_nonneg (Real.sin (θ n))]
