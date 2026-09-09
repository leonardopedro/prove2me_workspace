import Mathlib
import BookProof.ChapterBayesInference

/-!
# Uniform priors, relabeling symmetry, and maximum likelihood

This file formalizes two adjacent finite claims from the Bayesian chapters of
`book.tex` (around lines 1710--1720 and 9125--9450):

* a prior that treats every relabeling of a finite hypothesis space identically
  must be uniform; and
* with a positive uniform prior, maximizing the posterior is exactly maximizing
  the likelihood.

Thus the finite uniform prior is characterized by complete label symmetry, and
its MAP rule is the maximum-likelihood rule.  The broader philosophical claims
about non-informative priors are left as prose.
-/

open scoped BigOperators

namespace BookProof.ChapterUniformPrior

variable {Hyp Data : Type*}

/-- A weight function is invariant under every relabeling of hypotheses. -/
def IsRelabelingInvariant (p : Hyp → ℝ) : Prop :=
  ∀ σ : Equiv.Perm Hyp, p ∘ σ = p

/-
Complete relabeling invariance forces all hypothesis weights to coincide.
-/
theorem eq_of_isRelabelingInvariant (p : Hyp → ℝ)
    (hp : IsRelabelingInvariant p) (a b : Hyp) : p a = p b := by
  classical
  have h := congr_fun (hp (Equiv.swap a b)) b
  simpa [Function.comp_apply] using h

/-
Relabeling invariance is equivalent to being a constant weight function.
-/
theorem isRelabelingInvariant_iff_constant (p : Hyp → ℝ) :
    IsRelabelingInvariant p ↔ ∃ c : ℝ, p = fun _ => c := by
  constructor
  · intro hp
    cases isEmpty_or_nonempty Hyp with
    | inl hempty =>
        exact ⟨0, funext fun x => isEmptyElim x⟩
    | inr hnonempty =>
        let a : Hyp := Classical.choice hnonempty
        exact ⟨p a, funext fun x => eq_of_isRelabelingInvariant p hp x a⟩
  · rintro ⟨c, rfl⟩
    exact fun _ => rfl

/-
On a nonempty finite space, the normalized relabeling-invariant prior is
uniquely the uniform distribution `1 / |Hyp|`.
-/
theorem normalized_isRelabelingInvariant_eq_uniform [Fintype Hyp] [Nonempty Hyp]
    (p : Hyp → ℝ) (hp : IsRelabelingInvariant p) (hsum : ∑ x, p x = 1) :
    p = fun _ => (1 : ℝ) / Fintype.card Hyp := by
  obtain ⟨c, hc⟩ := isRelabelingInvariant_iff_constant p |>.1 hp;
  simp_all only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, funext_iff, one_div,
      forall_const];
  exact eq_inv_of_mul_eq_one_right hsum

/-
A positive uniform prior preserves every pairwise likelihood comparison in
its posterior, provided the observed datum has positive evidence.
-/
theorem uniform_prior_posterior_le_iff [Fintype Hyp]
    (likelihood : Hyp → Data → ℝ) (d : Data) (c : ℝ)
    (hc : 0 < c)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence (fun _ : Hyp => c) likelihood d)
    (a b : Hyp) :
    BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d a ≤
        BookProof.ChapterBayesInference.posterior (fun _ : Hyp => c) likelihood d b ↔
      likelihood a d ≤ likelihood b d := by
  simp_all only [ChapterBayesInference.evidence, ChapterBayesInference.posterior];
  rw [ div_le_div_iff_of_pos_right hevidence, mul_le_mul_iff_right₀ hc ]

/-
Consequently, under a positive uniform prior a hypothesis is MAP exactly
when it is a maximum-likelihood hypothesis.
-/
theorem uniform_prior_isMAP_iff_isMLE [Fintype Hyp]
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

end BookProof.ChapterUniformPrior
