import Mathlib
import BookProof.ChapterBayesInference

/-!
# Every finite prior is a posterior from uniform prior and suitable data

This file formalizes the next self-contained Bayesian claim in `book.tex` around
lines 1749--1760: results obtained from a non-uniform prior can be represented
using a uniform prior with suitable data.

For a finite target distribution `q`, use binary data and the likelihood
`L x true = q x`, `L x false = 1 - q x`.  Every row of `L` is a probability
distribution.  Conditioning any positive constant (uniform) prior on `true`
then returns exactly `q`.
-/

open scoped BigOperators

namespace BookProof.ChapterUniformPriorPosterior

variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]

/-- Binary likelihood whose `true` probability is the prescribed weight. -/
def binaryLikelihood (q : Hyp → ℝ) (x : Hyp) (observed : Bool) : ℝ :=
  if observed then q x else 1 - q x

omit [DecidableEq Hyp] in
/-
Every coordinate of a finite probability distribution is at most one.
-/
theorem probability_weight_le_one (q : Hyp → ℝ) (hq_nonneg : ∀ x, 0 ≤ q x)
    (hq_sum : ∑ x, q x = 1) (x : Hyp) : q x ≤ 1 := by
  exact hq_sum ▸ Finset.single_le_sum (fun y _ => hq_nonneg y) (Finset.mem_univ x)

omit [DecidableEq Hyp] in
/-
The binary likelihood is nonnegative when `q` is a probability distribution.
-/
theorem binaryLikelihood_nonneg (q : Hyp → ℝ) (hq_nonneg : ∀ x, 0 ≤ q x)
    (hq_sum : ∑ x, q x = 1) (x : Hyp) (observed : Bool) :
    0 ≤ binaryLikelihood q x observed := by
  cases observed <;>
    simp [binaryLikelihood, hq_nonneg,
      probability_weight_le_one q hq_nonneg hq_sum]

omit [Fintype Hyp] [DecidableEq Hyp] in
/-- Each row of the binary likelihood sums to one. -/
theorem binaryLikelihood_sum (q : Hyp → ℝ) (x : Hyp) :
    ∑ observed : Bool, binaryLikelihood q x observed = 1 := by
  simp [binaryLikelihood]

omit [DecidableEq Hyp] in
/-
Under a positive constant prior, the evidence for `true` is the constant.
-/
theorem uniform_binary_evidence (q : Hyp → ℝ) (hq_sum : ∑ x, q x = 1)
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
theorem uniform_prior_posterior_eq (q : Hyp → ℝ) (hq_sum : ∑ x, q x = 1)
    (c : ℝ) (hc : 0 < c) (x : Hyp) :
    BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c)
      (binaryLikelihood q) true x = q x := by
  unfold ChapterBayesInference.posterior
  rw [uniform_binary_evidence q hq_sum, mul_div_cancel_left₀ _ hc.ne']
  exact if_pos rfl

omit [DecidableEq Hyp] in
/-
Existential form of the book's claim: a suitable valid likelihood turns a
positive uniform prior into any prescribed finite probability distribution.
-/
theorem exists_likelihood_uniform_prior_posterior (q : Hyp → ℝ)
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

end BookProof.ChapterUniformPriorPosterior
