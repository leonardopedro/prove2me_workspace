-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.bornProb_nonneg
import Mathlib
import Definitions.Def_ChapterEulerNState
import Theorems.Thm_BookProof_ChapterEulerNState_eulerWave_sq
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (n k : ℕ) : 0 ≤ bornProb θ n k := by

  rw [← eulerWave_sq]; exact sq_nonneg _
