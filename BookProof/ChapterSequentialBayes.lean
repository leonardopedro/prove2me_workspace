import Mathlib
import BookProof.ChapterBayesInference

/-!
# Chapter "Aligned deep learning as a random sampling method", §3
"Bayesian inference in the presence of Big Data" — **sequential Bayesian updating
equals batch updating**

Source: `book.tex`.  The book stresses (chapter *"Aligned deep learning as a
random sampling method"*, §3, `book.tex` line ~9858) that

> *"Bayesian inference is still valid in the presence of Big Data, since it is
> valid for an arbitrarily large number of random variables, as long as it is a
> finite number."*

and (§2, `book.tex` line ~9803) that a brain does *"Bayesian learning in a
standard probability space … where the posterior probability is the output"*.

The precise, self-contained mathematical fact underlying "validity for an
arbitrarily large but finite number of observations" is the **coherence
(associativity) of Bayesian updating**: processing observations *one at a time*
(using each posterior as the prior for the next update) yields *exactly* the same
final posterior as processing them *all at once* in a single batch update, as
long as the observations are conditionally independent given the hypothesis
(so their likelihoods multiply).  Consequently a Bayesian learner can ingest an
arbitrarily long finite stream of data sequentially without any loss compared to
the (usually intractable) batch computation.

This module formalizes that fact.  For a finite hypothesis space `X`, a prior
`prior : X → ℝ` and a likelihood weight `ℓ : X → ℝ` (the value `ℓ x = L(x, y)`
of the likelihood at the observed data `y`), the **Bayes update** is

`bayesUpdate prior ℓ x = prior x · ℓ x / (∑_{x'} prior x' · ℓ x')`.

Deliverables (all `sorry`-free, `axiom`-free):

* `bayesUpdate_nonneg` — the updated distribution is nonnegative;
* `bayesUpdate_sum_one` — with positive evidence it is a probability distribution;
* `bayesUpdate_evidence` — the intermediate second-step evidence factorizes as
  `(∑ prior·ℓ₁·ℓ₂) / (∑ prior·ℓ₁)`;
* HEADLINE `sequential_eq_batch` — updating on `ℓ₁` and then on `ℓ₂` equals the
  single batch update on the product likelihood `ℓ₁ · ℓ₂`;
* `posterior_eq_bayesUpdate` — the book's `ChapterBayesInference.posterior`
  observing data `y` is exactly `bayesUpdate` with the likelihood column
  `x ↦ L x y`, so the coherence result transfers verbatim to that framework;
* `posterior_sequential_eq_batch` — the same coherence statement phrased with
  `posterior` and a conditionally-independent (product) two-observation
  likelihood.
-/

open scoped BigOperators

namespace BookProof.ChapterSequentialBayes

variable {X : Type*} [Fintype X]

/-- The **Bayes update** of a prior `prior : X → ℝ` by a likelihood weight
`ℓ : X → ℝ`: the (normalized) posterior `x ↦ prior x · ℓ x / ∑_{x'} prior x' · ℓ x'`. -/
noncomputable def bayesUpdate (prior ℓ : X → ℝ) : X → ℝ :=
  fun x => prior x * ℓ x / (∑ x', prior x' * ℓ x')

/-- The (batch) evidence `∑_x prior x · ℓ x`. -/
def totEvidence (prior ℓ : X → ℝ) : ℝ := ∑ x, prior x * ℓ x

/-- The Bayes update is nonnegative when the prior and the likelihood are. -/
theorem bayesUpdate_nonneg {prior ℓ : X → ℝ} (hprior : ∀ x, 0 ≤ prior x)
    (hℓ : ∀ x, 0 ≤ ℓ x) (x : X) : 0 ≤ bayesUpdate prior ℓ x := by
  unfold bayesUpdate
  apply div_nonneg (mul_nonneg (hprior x) (hℓ x))
  exact Finset.sum_nonneg fun i _ => mul_nonneg (hprior i) (hℓ i)

/-- With positive evidence, the Bayes update is a probability distribution. -/
theorem bayesUpdate_sum_one {prior ℓ : X → ℝ} (hpos : 0 < totEvidence prior ℓ) :
    ∑ x, bayesUpdate prior ℓ x = 1 := by
  unfold bayesUpdate
  rw [← Finset.sum_div]
  exact div_self (ne_of_gt hpos)

/-- The evidence of the second step, when the first update used `ℓ₁`, equals the
batch evidence of `ℓ₁ · ℓ₂` divided by the evidence of `ℓ₁`. -/
theorem bayesUpdate_evidence {prior ℓ₁ ℓ₂ : X → ℝ} :
    (∑ x, bayesUpdate prior ℓ₁ x * ℓ₂ x)
      = (∑ x, prior x * (ℓ₁ x * ℓ₂ x)) / (∑ x, prior x * ℓ₁ x) := by
  unfold bayesUpdate
  rw [Finset.sum_div]
  exact Finset.sum_congr rfl (fun x _ => by ring)

/-- **HEADLINE — sequential Bayesian updating equals batch updating.**
Updating a prior on the likelihood `ℓ₁` and then on `ℓ₂` yields exactly the same
posterior as the single batch update on the product likelihood `ℓ₁ · ℓ₂`
(conditional independence of the two observations given the hypothesis), provided
the evidences are positive. -/
theorem sequential_eq_batch {prior ℓ₁ ℓ₂ : X → ℝ}
    (h1 : 0 < totEvidence prior ℓ₁)
    (h2 : 0 < totEvidence prior (fun x => ℓ₁ x * ℓ₂ x)) :
    bayesUpdate (bayesUpdate prior ℓ₁) ℓ₂ = bayesUpdate prior (fun x => ℓ₁ x * ℓ₂ x) := by
  have hZ1 : (∑ x', prior x' * ℓ₁ x') ≠ 0 := ne_of_gt h1
  have hZc : (∑ x', prior x' * (ℓ₁ x' * ℓ₂ x')) ≠ 0 := ne_of_gt h2
  funext x
  have hstep : bayesUpdate (bayesUpdate prior ℓ₁) ℓ₂ x
      = bayesUpdate prior ℓ₁ x * ℓ₂ x / (∑ x', bayesUpdate prior ℓ₁ x' * ℓ₂ x') := rfl
  rw [hstep, bayesUpdate_evidence]
  unfold bayesUpdate
  field_simp

/-- The book's `ChapterBayesInference.posterior` observing data `y` is the Bayes
update with the likelihood column `x ↦ L x y`. -/
theorem posterior_eq_bayesUpdate {Y : Type*}
    (prior : X → ℝ) (L : X → Y → ℝ) (y : Y) :
    BookProof.ChapterBayesInference.posterior prior L y = bayesUpdate prior (fun x => L x y) := by
  funext x
  rfl

/-- **Coherence in the book's Bayesian-inference framework.** For two
observations `y₁, y₂` that are conditionally independent given the hypothesis
(their combined likelihood being the product `L₁ x y₁ · L₂ x y₂`), the posterior
obtained by updating first on `y₁` and then on `y₂` equals the batch posterior
computed from the product likelihood. -/
theorem posterior_sequential_eq_batch {Y₁ Y₂ : Type*}
    (prior : X → ℝ) (L₁ : X → Y₁ → ℝ) (L₂ : X → Y₂ → ℝ) (y₁ : Y₁) (y₂ : Y₂)
    (h1 : 0 < totEvidence prior (fun x => L₁ x y₁))
    (h2 : 0 < totEvidence prior (fun x => L₁ x y₁ * L₂ x y₂)) :
    bayesUpdate (BookProof.ChapterBayesInference.posterior prior L₁ y₁) (fun x => L₂ x y₂)
      = bayesUpdate prior (fun x => L₁ x y₁ * L₂ x y₂) := by
  rw [posterior_eq_bayesUpdate]
  exact sequential_eq_batch h1 h2

end BookProof.ChapterSequentialBayes
