-- Generated from ChapterBijectionProbability.lean — solution of BookProof.ChapterBijectionProbability.bijProb_nonneg
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability



open scoped Nat
open Filter Asymptotics

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : 0 ≤ bijProb n := by

  unfold bijProb; positivity
