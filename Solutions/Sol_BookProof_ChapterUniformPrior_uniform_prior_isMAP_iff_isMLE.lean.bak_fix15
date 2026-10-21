-- Generated from ChapterUniformPrior.lean — solution of BookProof.ChapterUniformPrior.uniform_prior_isMAP_iff_isMLE
import Mathlib
import Definitions.Def_ChapterUniformPrior
import Theorems.Thm_BookProof_ChapterUniformPrior_uniform_prior_posterior_le_iff
open BookProof.ChapterUniformPrior



open scoped BigOperators


variable {Hyp Data : Type*}

variable {Hyp Data : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [Fintype Hyp]
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ)
    (hc : 0 < c)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c) likelihood d)
    (best : Hyp) :
    (∀ m, BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d m ≤
        BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d best) ↔
      ∀ m, likelihood m d ≤ likelihood best d := by

  constructor
  · intro h m
    exact (uniform_prior_posterior_le_iff likelihood d c hc hevidence m best).mp (h m)
  · intro h m
    exact (uniform_prior_posterior_le_iff likelihood d c hc hevidence m best).mpr (h m)
