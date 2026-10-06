-- Generated from ChapterEntropy.lean — solution of BookProof.ChapterEntropy.invertibleProb_nonneg
import Mathlib
import Definitions.Def_ChapterEntropy
import Theorems.Thm_BookProof_ChapterEntropy_invertibleProb_eq
open BookProof.ChapterEntropy




open Filter Asymptotics
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : 0 ≤ invertibleProb n := by

  rw [invertibleProb_eq]; positivity
