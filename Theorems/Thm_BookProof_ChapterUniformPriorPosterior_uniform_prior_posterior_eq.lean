-- Generated from ChapterUniformPriorPosterior.lean — theorem BookProof.ChapterUniformPriorPosterior.uniform_prior_posterior_eq
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterUniformPriorPosterior

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]


open scoped BigOperators



theorem BookProof.ChapterUniformPriorPosterior.uniform_prior_posterior_eq (q : Hyp → ℝ) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) (hc : 0 < c) (x : Hyp) :
    BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c)
      (binaryLikelihood q) true x = q x := by sorry
