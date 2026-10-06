-- Generated from ChapterNoBestPrior.lean — solution of BookProof.ChapterNoBestPrior.distinct_priors_each_preferred
import Mathlib
import Definitions.Def_ChapterNoBestPrior
import Theorems.Thm_BookProof_ChapterNoBestPrior_not_uniformly_better
open BookProof.ChapterNoBestPrior



open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp]

variable {Hyp : Type*} [Fintype Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Hyp → ℝ) (hpq : p ≠ q) :
    (∃ u, expectedUtility q u < expectedUtility p u) ∧
      ∃ v, expectedUtility p v < expectedUtility q v := by

  constructor
  · simpa only [not_forall, not_le] using not_uniformly_better q p hpq.symm
  · simpa only [not_forall, not_le] using not_uniformly_better p q hpq
