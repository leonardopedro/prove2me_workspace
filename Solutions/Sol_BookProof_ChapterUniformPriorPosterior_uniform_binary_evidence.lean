-- Generated from ChapterUniformPriorPosterior.lean — solution of BookProof.ChapterUniformPriorPosterior.uniform_binary_evidence
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Definitions.Def_ChapterBayesInference
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterUniformPriorPosterior



open scoped BigOperators
open BookProof.ChapterBayesInference
open BookProof.ChapterDeepLearningSampling


variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

set_option maxHeartbeats 1000000 in

theorem solution (q : Hyp → ℝ) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) :
    BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c)
      (binaryLikelihood q) true = c := by
  unfold ChapterBayesInference.evidence binaryLikelihood
  simp [← Finset.mul_sum, hq_sum]

omit [DecidableEq Hyp] in
/-
Every finite probability distribution is exactly the posterior obtained by
conditioning a positive uniform prior on suitable binary data.
-/
