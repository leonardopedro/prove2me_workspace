-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.eulerWave_sq
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (n k : ℕ) :
    (eulerWave θ n k) ^ 2 = bornProb θ n k := by

  unfold eulerWave bornProb tailProd
  split_ifs with h1 h2
  · rw [mul_pow, ← Finset.prod_pow]
  · rw [← Finset.prod_pow]
  · ring
