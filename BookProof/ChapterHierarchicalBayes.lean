import Mathlib
import BookProof.ChapterSequentialBayes

/-!
# Hierarchical Bayesian inference

This module formalizes a finite mathematical core of §11 of the chapter
"Aligned deep learning as a random sampling method" (`book.tex` around line
10484).  The book observes that an inference problem may contain another
inference problem and that the hierarchy may have arbitrarily many finite
levels.  Here a two-level hierarchy has an outer latent state `a`, an inner
latent state `b` conditional on `a`, and a data likelihood depending on both.
The results show that the hierarchy can be flattened to the joint state space,
or the inner level can be marginalized first, with exactly the same evidence
and outer posterior.
-/

open scoped BigOperators

namespace BookProof.ChapterHierarchicalBayes

variable {A B : Type*} [Fintype A] [Fintype B]

/-- Joint prior induced by an outer prior and an inner conditional prior. -/
def jointPrior (outer : A → ℝ) (inner : A → B → ℝ) (a : A) (b : B) : ℝ :=
  outer a * inner a b

/-- Evidence in the two-level hierarchical model. -/
def hierEvidence (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) : ℝ :=
  ∑ a, ∑ b, jointPrior outer inner a b * likelihood a b

/-- Likelihood at the outer level after marginalizing the inner latent state. -/
def marginalLikelihood (inner : A → B → ℝ) (likelihood : A → B → ℝ)
    (a : A) : ℝ :=
  ∑ b, inner a b * likelihood a b

/-- Posterior on the flattened joint latent state. -/
noncomputable def flatPosterior (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) (a : A) (b : B) : ℝ :=
  jointPrior outer inner a b * likelihood a b /
    hierEvidence outer inner likelihood

/-- Posterior on the outer state after the inner state is marginalized. -/
noncomputable def outerPosterior (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) (a : A) : ℝ :=
  outer a * marginalLikelihood inner likelihood a /
    hierEvidence outer inner likelihood

/-- Normalized outer and conditional priors induce a normalized joint prior. -/
theorem jointPrior_sum_one (outer : A → ℝ) (inner : A → B → ℝ)
    (hOuter : ∑ a, outer a = 1) (hInner : ∀ a, ∑ b, inner a b = 1) :
    ∑ a, ∑ b, jointPrior outer inner a b = 1 := by
  simp only [jointPrior]
  rw [show ∑ a, ∑ b, outer a * inner a b = ∑ a, outer a * ∑ b, inner a b by
    congr 1 with a
    rw [← Finset.mul_sum]]
  simp [hInner, hOuter]

omit [Fintype A] [Fintype B] in
/-- Nonnegative ingredients induce a nonnegative joint prior. -/
theorem jointPrior_nonneg (outer : A → ℝ) (inner : A → B → ℝ)
    (hOuter : ∀ a, 0 ≤ outer a) (hInner : ∀ a b, 0 ≤ inner a b) :
    ∀ a b, 0 ≤ jointPrior outer inner a b := by
  intro a b
  rw [jointPrior]
  exact mul_nonneg (hOuter a) (hInner a b)

/-- Marginalizing the inner level first gives exactly the same evidence. -/
theorem evidence_eq_marginal (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) :
    hierEvidence outer inner likelihood =
      ∑ a, outer a * marginalLikelihood inner likelihood a := by
  unfold hierEvidence marginalLikelihood jointPrior
  apply Finset.sum_congr rfl
  intro a ha
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro b hb
  ring

/-- The outer posterior is the marginal of the flattened joint posterior. -/
theorem outerPosterior_eq_sum_flat (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) (a : A) :
    outerPosterior outer inner likelihood a =
      ∑ b, flatPosterior outer inner likelihood a b := by
  unfold outerPosterior flatPosterior marginalLikelihood jointPrior
  rw [Finset.mul_sum, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro b hb
  ring

/-- With positive evidence, the flattened posterior is normalized. -/
theorem flatPosterior_sum_one (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ)
    (hEvidence : 0 < hierEvidence outer inner likelihood) :
    ∑ a, ∑ b, flatPosterior outer inner likelihood a b = 1 := by
  unfold flatPosterior hierEvidence
  simp only [jointPrior]
  rw [show ∑ a, ∑ b, outer a * inner a b * likelihood a b /
        (∑ a, ∑ b, outer a * inner a b * likelihood a b) =
      (∑ a, ∑ b, outer a * inner a b * likelihood a b) /
        (∑ a, ∑ b, outer a * inner a b * likelihood a b) by
    rw [Finset.sum_div]
    congr 1 with a
    rw [Finset.sum_div]]
  exact div_self (ne_of_gt hEvidence)

/-- With positive evidence, the marginalized outer posterior is normalized. -/
theorem outerPosterior_sum_one (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ)
    (hEvidence : 0 < hierEvidence outer inner likelihood) :
    ∑ a, outerPosterior outer inner likelihood a = 1 := by
  rw [show ∑ a, outerPosterior outer inner likelihood a =
      ∑ a, ∑ b, flatPosterior outer inner likelihood a b by
    apply Finset.sum_congr rfl
    intro a ha
    exact outerPosterior_eq_sum_flat outer inner likelihood a]
  exact flatPosterior_sum_one outer inner likelihood hEvidence

/-- The outer posterior is an ordinary Bayes update using the marginalized
likelihood.  Thus a finite nested inference can be replaced by one batch
inference without changing its answer. -/
theorem outerPosterior_eq_bayesUpdate (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) :
    outerPosterior outer inner likelihood =
      BookProof.ChapterSequentialBayes.bayesUpdate outer
        (marginalLikelihood inner likelihood) := by
  funext a
  unfold outerPosterior BookProof.ChapterSequentialBayes.bayesUpdate
  rw [evidence_eq_marginal]

end BookProof.ChapterHierarchicalBayes
