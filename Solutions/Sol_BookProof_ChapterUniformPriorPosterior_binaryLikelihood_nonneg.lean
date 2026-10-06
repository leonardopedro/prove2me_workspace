-- Generated from ChapterUniformPriorPosterior.lean — solution of BookProof.ChapterUniformPriorPosterior.binaryLikelihood_nonneg
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Theorems.Thm_BookProof_ChapterUniformPriorPosterior_probability_weight_le_one
open BookProof.ChapterUniformPriorPosterior



open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (q : Hyp → ℝ) (hq_nonneg : ∀ x, 0 ≤ q x)
    (hq_sum : ∑ x, q x = 1) (x : Hyp) (observed : Bool) :
    0 ≤ binaryLikelihood q x observed := by

  cases observed <;>
    simp [binaryLikelihood, hq_nonneg,
      probability_weight_le_one q hq_nonneg hq_sum]
