import Mathlib
import BookProof.ChapterBayesInference

/-!
# Book chapter "Consciousness as a representation of a Bayesian prior"

This file formalizes the elementary Bayesian core of §"A deterministic prior is
still subjective" (`book.tex` lines 9208–9267).  A deterministic prior is a
Dirac mass.  Conditioning it on data of positive likelihood leaves it a Dirac
mass; choosing a different deterministic prior can therefore give a different
posterior from the same likelihood and observation.

The philosophical discussion surrounding these identities remains prose.
-/

open scoped BigOperators

namespace BookProof.ChapterPriorDependence

variable {Hyp Data : Type*} [DecidableEq Hyp]

/-- Deterministic (Dirac) prior concentrated at `a`. -/
def diracPrior (a : Hyp) (x : Hyp) : ℝ := if x = a then 1 else 0

theorem diracPrior_nonneg (a x : Hyp) : 0 ≤ diracPrior a x := by
  unfold diracPrior
  split_ifs <;> norm_num

variable [Fintype Hyp]

theorem diracPrior_sum_one (a : Hyp) : ∑ x, diracPrior a x = 1 := by
  unfold diracPrior
  aesop

/-
Evidence under a deterministic prior is just the likelihood at its support.
-/
theorem evidence_dirac (a : Hyp) (L : Hyp → Data → ℝ) (d : Data) :
    BookProof.ChapterBayesInference.evidence (diracPrior a) L d = L a d := by
  unfold ChapterBayesInference.evidence
  simp [diracPrior]

/-
Positive-likelihood Bayesian updating preserves a deterministic prior.
-/
theorem posterior_dirac (a : Hyp) (L : Hyp → Data → ℝ) (d : Data)
    (ha : 0 < L a d) (x : Hyp) :
    BookProof.ChapterBayesInference.posterior (diracPrior a) L d x =
      diracPrior a x := by
  unfold ChapterBayesInference.posterior diracPrior
  split_ifs <;> simp_all [ChapterBayesInference.evidence]
  linarith

/-
Two distinct deterministic prior assumptions yield distinct posteriors for
the same data whenever the first supported hypothesis has positive likelihood.
-/
theorem distinct_priors_distinct_posteriors (a b : Hyp) (hab : a ≠ b)
    (L : Hyp → Data → ℝ) (d : Data) (ha : 0 < L a d) :
    BookProof.ChapterBayesInference.posterior (diracPrior a) L d ≠
      BookProof.ChapterBayesInference.posterior (diracPrior b) L d := by
  intro h
  have heq := congrFun h a
  rw [posterior_dirac a L d ha a] at heq
  simp [diracPrior, hab, BookProof.ChapterBayesInference.posterior] at heq

end BookProof.ChapterPriorDependence
