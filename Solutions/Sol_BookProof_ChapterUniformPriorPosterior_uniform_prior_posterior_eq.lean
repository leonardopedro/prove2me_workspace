-- Generated from ChapterUniformPriorPosterior.lean — solution of BookProof.ChapterUniformPriorPosterior.uniform_prior_posterior_eq
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Theorems.Thm_BookProof_ChapterUniformPriorPosterior_uniform_binary_evidence
open BookProof.ChapterUniformPriorPosterior



open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (q : Hyp → ℝ) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) (hc : 0 < c) (x : Hyp) :
    BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c)
      (binaryLikelihood q) true x = q x := by

  unfold ChapterBayesInference.posterior
  rw [uniform_binary_evidence q hq_sum, mul_div_cancel_left₀ _ hc.ne']
  exact if_pos rfl
