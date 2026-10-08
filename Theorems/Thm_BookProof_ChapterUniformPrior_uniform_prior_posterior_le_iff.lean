-- Generated from ChapterUniformPrior.lean — theorem BookProof.ChapterUniformPrior.uniform_prior_posterior_le_iff
import Mathlib
import Definitions.Def_ChapterUniformPrior
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterUniformPrior


open scoped BigOperators


variable {Hyp Data : Type*}


theorem BookProof.ChapterUniformPrior.uniform_prior_posterior_le_iff [Fintype Hyp]
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ)
    (hc : 0 < c)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c) likelihood d)
    (a b : Hyp) :
    BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d a ≤
        BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d b ↔
      likelihood a d ≤ likelihood b d := by sorry
