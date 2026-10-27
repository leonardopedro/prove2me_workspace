-- Generated from ChapterUniformPriorPosterior.lean — solution of BookProof.ChapterUniformPriorPosterior.exists_likelihood_uniform_prior_posterior
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Theorems.Thm_BookProof_ChapterUniformPriorPosterior_binaryLikelihood_nonneg
import Theorems.Thm_BookProof_ChapterUniformPriorPosterior_binaryLikelihood_sum
import Theorems.Thm_BookProof_ChapterUniformPriorPosterior_uniform_prior_posterior_eq
open BookProof.ChapterUniformPriorPosterior



open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (q : Hyp → ℝ)
    (hq_nonneg : ∀ x, 0 ≤ q x) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) (hc : 0 < c) :
    ∃ L : Hyp → Bool → ℝ,
      (∀ x observed, 0 ≤ L x observed) ∧
      (∀ x, ∑ observed, L x observed = 1) ∧
      (∀ x, BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c)
        L true x = q x) := by

  refine ⟨binaryLikelihood q, ?_, binaryLikelihood_sum q, ?_⟩
  · exact binaryLikelihood_nonneg q hq_nonneg hq_sum
  · exact uniform_prior_posterior_eq q hq_sum c hc
