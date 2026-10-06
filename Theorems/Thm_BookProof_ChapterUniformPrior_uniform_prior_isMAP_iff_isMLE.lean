-- Generated from ChapterUniformPrior.lean — theorem BookProof.ChapterUniformPrior.uniform_prior_isMAP_iff_isMLE
import Mathlib
import Definitions.Def_ChapterUniformPrior
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterUniformPrior

variable {Hyp Data : Type*}


open scoped BigOperators



theorem BookProof.ChapterUniformPrior.uniform_prior_isMAP_iff_isMLE [Fintype Hyp]
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ)
    (hc : 0 < c)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c) likelihood d)
    (best : Hyp) :
    (∀ m, BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d m ≤
        BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d best) ↔
      ∀ m, likelihood m d ≤ likelihood best d := by sorry
