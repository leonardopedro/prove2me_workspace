import Mathlib
import BookProof.ChapterBayesInference

/-!
# Prior dependence and posterior odds

This file extends the mathematical core extracted from `book.tex` lines
9208–9473.  The chapter's claim that different priors can interpret the same
data differently has a precise Bayesian form: posterior odds equal prior odds
times the likelihood ratio.  In particular, equally likely data do not erase
prior disagreement.
-/

namespace BookProof.ChapterPriorOdds

variable {Hyp Data : Type*} [Fintype Hyp]

/-
Cross-multiplied posterior-odds identity, avoiding division by individual
prior or likelihood values.
-/
theorem posterior_odds_cross_mul (prior : Hyp → ℝ)
    (likelihood : Hyp → Data → ℝ) (d : Data) (a b : Hyp) :
    BookProof.ChapterBayesInference.posterior prior likelihood d a *
        (prior b * likelihood b d) =
      BookProof.ChapterBayesInference.posterior prior likelihood d b *
        (prior a * likelihood a d) := by
  unfold ChapterBayesInference.posterior
  ring

/-
When all terms are positive, posterior odds are prior odds multiplied by
the likelihood ratio.
-/
theorem posterior_odds (prior : Hyp → ℝ) (likelihood : Hyp → Data → ℝ)
    (d : Data) (he : 0 < BookProof.ChapterBayesInference.evidence prior likelihood d)
    (hb : 0 < prior b) (hlb : 0 < likelihood b d) :
    BookProof.ChapterBayesInference.posterior prior likelihood d a /
        BookProof.ChapterBayesInference.posterior prior likelihood d b =
      (prior a / prior b) * (likelihood a d / likelihood b d) := by
  unfold ChapterBayesInference.posterior
  grind

/-
If the observation has the same positive likelihood under two hypotheses,
conditioning preserves their prior odds.
-/
theorem equal_likelihood_preserves_odds (prior : Hyp → ℝ)
    (likelihood : Hyp → Data → ℝ) (d : Data)
    (he : 0 < BookProof.ChapterBayesInference.evidence prior likelihood d)
    (hb : 0 < prior b)
    (hl : likelihood a d = likelihood b d) (hlpos : 0 < likelihood b d) :
    BookProof.ChapterBayesInference.posterior prior likelihood d a /
        BookProof.ChapterBayesInference.posterior prior likelihood d b =
      prior a / prior b := by
  rw [ChapterBayesInference.posterior, ChapterBayesInference.posterior,
    div_div_div_comm]
  grind

/-
Scaling every likelihood by a common factor scales the evidence by that
factor.
-/
theorem evidence_scale_likelihood (prior : Hyp → ℝ)
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ) :
    BookProof.ChapterBayesInference.evidence prior
        (fun h d => c * likelihood h d) d =
      c * BookProof.ChapterBayesInference.evidence prior likelihood d := by
  unfold ChapterBayesInference.evidence
  simp only [mul_left_comm, Finset.mul_sum]

/-
Multiplying every likelihood by the same positive constant does not change
the posterior.
-/
theorem posterior_scale_likelihood (prior : Hyp → ℝ)
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ) (hc : 0 < c)
    (x : Hyp) :
    BookProof.ChapterBayesInference.posterior prior (fun h d => c * likelihood h d) d x =
      BookProof.ChapterBayesInference.posterior prior likelihood d x := by
  unfold ChapterBayesInference.posterior
  simp only [evidence_scale_likelihood]
  rw [mul_left_comm, mul_div_mul_left _ _ hc.ne']

end BookProof.ChapterPriorOdds
