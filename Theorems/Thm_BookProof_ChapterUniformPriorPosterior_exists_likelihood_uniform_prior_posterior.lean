-- Generated from ChapterUniformPriorPosterior.lean — theorem BookProof.ChapterUniformPriorPosterior.exists_likelihood_uniform_prior_posterior
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterUniformPriorPosterior

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]


open scoped BigOperators



theorem BookProof.ChapterUniformPriorPosterior.exists_likelihood_uniform_prior_posterior (q : Hyp → ℝ)
    (hq_nonneg : ∀ x, 0 ≤ q x) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) (hc : 0 < c) :
    ∃ L : Hyp → Bool → ℝ,
      (∀ x observed, 0 ≤ L x observed) ∧
      (∀ x, ∑ observed, L x observed = 1) ∧
      (∀ x, BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c)
        L true x = q x) := by sorry
