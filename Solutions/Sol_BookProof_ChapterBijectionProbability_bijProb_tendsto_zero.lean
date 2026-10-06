-- Generated from ChapterBijectionProbability.lean — solution of BookProof.ChapterBijectionProbability.bijProb_tendsto_zero
import Mathlib
import Definitions.Def_ChapterBijectionProbability
import Theorems.Thm_BookProof_ChapterBijectionProbability_bijProb_nonneg
import Theorems.Thm_BookProof_ChapterBijectionProbability_bijProb_le_one_div
open BookProof.ChapterBijectionProbability



open scoped Nat
open Filter Asymptotics

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto bijProb atTop (nhds 0) := by

  apply squeeze_zero' (f := bijProb) (g := fun n : ℕ => 1 / (n : ℝ))
  · exact Eventually.of_forall bijProb_nonneg
  · filter_upwards [eventually_ge_atTop 1] with n hn using bijProb_le_one_div n hn
  · exact tendsto_one_div_atTop_nhds_zero_nat
