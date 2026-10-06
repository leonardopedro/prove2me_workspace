-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.euler_wave_unit
import Mathlib
import Definitions.Def_ChapterEulerNState
import Theorems.Thm_BookProof_ChapterEulerNState_eulerWave_sq
import Theorems.Thm_BookProof_ChapterEulerNState_euler_sum_one
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    ∑ k ∈ Finset.range n, (eulerWave θ n k) ^ 2 = 1 := by

  simp_rw [eulerWave_sq]; exact euler_sum_one θ hn
