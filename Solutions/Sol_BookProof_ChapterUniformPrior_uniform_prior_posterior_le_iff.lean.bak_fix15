-- Generated from ChapterUniformPrior.lean — solution of BookProof.ChapterUniformPrior.uniform_prior_posterior_le_iff
import Mathlib
import Definitions.Def_ChapterUniformPrior
open BookProof.ChapterUniformPrior



open scoped BigOperators


variable {Hyp Data : Type*}

variable {Hyp Data : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [Fintype Hyp]
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ)
    (hc : 0 < c)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c) likelihood d)
    (a b : Hyp) :
    BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d a ≤
        BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d b ↔
      likelihood a d ≤ likelihood b d := by

  simp_all only [ChapterBayesInference.evidence, ChapterBayesInference.posterior];
  rw [ div_le_div_iff_of_pos_right hevidence, mul_le_mul_iff_right₀ hc ]
