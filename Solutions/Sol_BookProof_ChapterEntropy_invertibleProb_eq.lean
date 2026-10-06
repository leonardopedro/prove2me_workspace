-- Generated from ChapterEntropy.lean — solution of BookProof.ChapterEntropy.invertibleProb_eq
import Mathlib
import Definitions.Def_ChapterEntropy
import Theorems.Thm_BookProof_ChapterEntropy_card_bijections
open BookProof.ChapterEntropy




open Filter Asymptotics
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    invertibleProb n = (Nat.factorial n : ℝ) / (n ^ n : ℝ) := by

  simp [invertibleProb, card_bijections]
