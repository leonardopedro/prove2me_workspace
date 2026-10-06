-- Generated from ChapterEulerCountableChain.lean — solution of BookProof.ChapterEulerCountableChain.one_sub_condCos
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain



open scoped BigOperators
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (n : ℕ) :
    1 - condCos θ n = Real.sin (θ n) ^ 2 := by

  rw [condCos]
  nlinarith [Real.sin_sq_add_cos_sq (θ n)]
