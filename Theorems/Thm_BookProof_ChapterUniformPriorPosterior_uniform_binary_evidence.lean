-- Generated from ChapterUniformPriorPosterior.lean — theorem BookProof.ChapterUniformPriorPosterior.uniform_binary_evidence
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterUniformPriorPosterior


open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]


theorem BookProof.ChapterUniformPriorPosterior.uniform_binary_evidence (q : Hyp → ℝ) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) :
    BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c)
      (binaryLikelihood q) true = c := by sorry
