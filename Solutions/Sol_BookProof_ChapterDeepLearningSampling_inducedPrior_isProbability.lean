-- Generated from ChapterDeepLearningSampling.lean — solution of BookProof.ChapterDeepLearningSampling.inducedPrior_isProbability
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
import Theorems.Thm_BookProof_ChapterDeepLearningSampling_sum_inducedPrior_event
open BookProof.ChapterDeepLearningSampling



open scoped BigOperators


variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]

variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]

set_option maxHeartbeats 1000000 in
theorem solution [Fintype Model]
    (seedProb : Seed → ℝ) (train : Seed → Model)
    (hnonneg : ∀ s, 0 ≤ seedProb s) (hsum : ∑ s, seedProb s = 1) :
    (∀ m, 0 ≤ inducedPrior seedProb train m) ∧
      ∑ m, inducedPrior seedProb train m = 1 := by

  refine ⟨fun m => Finset.sum_nonneg fun s hs => hnonneg s, ?_⟩
  rw [← hsum, sum_inducedPrior_event]
  simp
