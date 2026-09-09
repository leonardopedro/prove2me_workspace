import Mathlib

/-!
# Chapter "Aligned deep learning as a random sampling method", §2
"Systematic uncertainties and Bayesian priors" — **the law of total variance
(within-group / between-group variance decomposition)**

Source: `book.tex`.  The book repeatedly frames *systematic uncertainties* as
Bayesian priors and discusses the decomposition of the uncertainty of a
prediction into a part that is intrinsic to the data ("aleatoric") and a part
that reflects our ignorance of which model / group generated it ("epistemic"):

> *"The systematic uncertainties in Engineering can be defined as Bayesian prior
> probability distributions … which describe previous knowledge about a system."*
> (`book.tex` §2, line ~9793)

and it stresses that ensemble forecasting — a *probability space of probability
spaces* — combines the variability *within* each member with the variability
*between* members (`book.tex` §10, line ~2005; `hullermeier_aleatoric_2021`).

The precise, self-contained mathematical fact underpinning that picture is the
classical **law of total variance**: if the outcomes are partitioned into groups
`X ω` (the "member" / conditioning variable), then the total variance of a
quantity `Y` splits *exactly* into

* the **within-group** ("aleatoric") variance — the mean of the conditional
  variances, and
* the **between-group** ("epistemic") variance — the variance of the conditional
  means.

This module formalizes that identity for a finite sample space, entirely
independently of the surrounding discussion.  For a finite sample space `Ω` with
nonnegative weights `w` (a probability distribution — although the algebraic
identity needs only nonnegativity), a real quantity `Y : Ω → ℝ`, and a grouping
`X : Ω → κ` into finitely many groups:

* `mean`, `groupProb`, `condMean` — the expectation `E[Y]`, the group
  probabilities `P(X = g)`, and the conditional means `E[Y | X = g]`
  (with the convention `0/0 = 0` on zero-probability groups);
* `variance`, `within`, `between` — the total variance `Var[Y]`, the mean of the
  conditional variances `E[Var(Y | X)]`, and the variance of the conditional
  means `Var(E[Y | X])`;
* `groupBalance` — for every group the `w`-weighted residuals `Y − E[Y|X]` sum to
  zero (the defining orthogonality of conditional expectation);
* `crossTerm_zero` — hence the cross term in the Pythagorean expansion vanishes;
* HEADLINE `total_variance` — `Var[Y] = E[Var(Y | X)] + Var(E[Y | X])`, i.e.
  `variance = within + between`;
* `within_nonneg`, `between_nonneg`, `variance_nonneg`, and the consequences
  `within_le_variance`, `between_le_variance`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace ChapterTotalVariance

open scoped BigOperators
open Finset

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

/-- The expectation `E[Y] = ∑_ω w(ω)·Y(ω)`. -/
def mean (w Y : Ω → ℝ) : ℝ := ∑ ω, w ω * Y ω

/-- The group probability `P(X = g) = ∑_{ω : X ω = g} w(ω)`. -/
def groupProb (w : Ω → ℝ) (X : Ω → κ) (g : κ) : ℝ :=
  ∑ ω, if X ω = g then w ω else 0

/-- The conditional mean `E[Y | X = g]`, with the convention `0/0 = 0` on a
zero-probability group. -/
noncomputable def condMean (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) (g : κ) : ℝ :=
  (∑ ω, if X ω = g then w ω * Y ω else 0) / groupProb w X g

/-- The total variance `Var[Y] = ∑_ω w(ω)·(Y(ω) − E[Y])²`. -/
def variance (w Y : Ω → ℝ) : ℝ := ∑ ω, w ω * (Y ω - mean w Y) ^ 2

/-- The within-group (aleatoric) variance `E[Var(Y | X)]`, written in the form
`∑_ω w(ω)·(Y(ω) − E[Y | X = X ω])²` in which the group-probability denominators
cancel. -/
noncomputable def within (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) : ℝ :=
  ∑ ω, w ω * (Y ω - condMean w X Y (X ω)) ^ 2

/-- The between-group (epistemic) variance `Var(E[Y | X])`, written as
`∑_ω w(ω)·(E[Y | X = X ω] − E[Y])²`. -/
noncomputable def between (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) : ℝ :=
  ∑ ω, w ω * (condMean w X Y (X ω) - mean w Y) ^ 2

/-- **Orthogonality of the conditional mean.**  For every group `g`, the
`w`-weighted residuals of `Y` about the conditional mean `E[Y | X = g]` sum to
zero.  (Uses nonnegativity of the weights only for the zero-probability group,
where every weight in the group must vanish.) -/
lemma groupBalance (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) (g : κ) :
    (∑ ω, if X ω = g then w ω * (Y ω - condMean w X Y g) else 0) = 0 := by
  -- Let `N = ∑ (if X ω = g then w ω * Y ω else 0)` and `P = groupProb w X g`.
  -- Distribute: the sum equals `N - condMean·P = N - (N / P)·P`.
  -- If `P ≠ 0`, `(N/P)·P = N` so the result is `0`.
  -- If `P = 0`, then `condMean = N/0 = 0`; and since `P = ∑ (if X ω = g then w ω else 0)`
  -- is a sum of nonnegatives equal to `0`, every `w ω` with `X ω = g` is `0`, hence `N = 0`.
  simp only [condMean]
  set P : ℝ := groupProb w X g with hP
  set N : ℝ := ∑ ω, if X ω = g then w ω * Y ω else 0 with hN
  have hdist : (∑ ω, if X ω = g then w ω * (Y ω - N / P) else 0) = N - (N / P) * P := by
    rw [hN, hP, groupProb, Finset.mul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl (fun ω _ => ?_)
    by_cases h : X ω = g
    · simp only [h, if_true]; ring
    · simp only [h, if_false, sub_zero, mul_zero]
  rw [hdist]
  by_cases hP0 : P = 0
  · have hNz : N = 0 := by
      have hnn : ∀ ω ∈ Finset.univ, (0 : ℝ) ≤ if X ω = g then w ω else 0 := by
        intro ω _; by_cases h : X ω = g <;> simp [h, hw ω]
      have hz := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 (by rw [← groupProb]; exact hP0)
      rw [hN]; refine Finset.sum_eq_zero (fun ω _ => ?_)
      by_cases h : X ω = g
      · have : w ω = 0 := by have := hz ω (Finset.mem_univ ω); simpa [h] using this
        simp [h, this]
      · simp [h]
    rw [hNz, hP0]; ring
  · rw [div_mul_cancel₀ N hP0, sub_self]

/-- The cross term of the Pythagorean expansion vanishes. -/
lemma crossTerm_zero [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    (∑ ω, w ω * (Y ω - condMean w X Y (X ω)) * (condMean w X Y (X ω) - mean w Y))
      = 0 := by
  letI := Fintype.ofFinite κ
  -- Regroup the sum over `ω` by the group value `g = X ω` using `Finset.sum_ite_eq`
  -- to introduce an inner sum over `g`, then swap and factor out `(condMean g - mean)`
  -- from each fiber; the remaining fiber sum is `groupBalance`, which is `0`.
  have key : ∀ ω, w ω * (Y ω - condMean w X Y (X ω)) * (condMean w X Y (X ω) - mean w Y)
      = ∑ g, if X ω = g then
          (condMean w X Y g - mean w Y) * (w ω * (Y ω - condMean w X Y g)) else 0 := by
    intro ω
    rw [Finset.sum_ite_eq Finset.univ (X ω)
      (fun g => (condMean w X Y g - mean w Y) * (w ω * (Y ω - condMean w X Y g)))]
    simp only [Finset.mem_univ, if_true]
    ring
  simp_rw [key]
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero (fun g _ => ?_)
  have : (∑ ω, if X ω = g then
      (condMean w X Y g - mean w Y) * (w ω * (Y ω - condMean w X Y g)) else 0)
      = (condMean w X Y g - mean w Y) *
        (∑ ω, if X ω = g then w ω * (Y ω - condMean w X Y g) else 0) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl (fun ω _ => ?_)
    by_cases h : X ω = g <;> simp [h]
  rw [this, groupBalance w X Y hw g, mul_zero]

/-- **Law of total variance.**  The total variance decomposes exactly into the
within-group (aleatoric) variance plus the between-group (epistemic) variance:
`Var[Y] = E[Var(Y | X)] + Var(E[Y | X])`. -/
theorem total_variance [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    variance w Y = within w X Y + between w X Y := by
  -- Pythagorean expansion: `(Y - μ)² = (Y - c)² + 2·(Y - c)·(c - μ) + (c - μ)²`
  -- where `c = condMean (X ω)` and `μ = mean`.  Sum termwise; the middle (cross)
  -- term is `2 * crossTerm_zero = 0`.
  have hcross := crossTerm_zero w X Y hw
  simp only [variance, within, between]
  rw [← sub_eq_zero]
  have expand : (∑ ω, w ω * (Y ω - mean w Y) ^ 2)
      - ((∑ ω, w ω * (Y ω - condMean w X Y (X ω)) ^ 2)
         + ∑ ω, w ω * (condMean w X Y (X ω) - mean w Y) ^ 2)
      = 2 * (∑ ω, w ω * (Y ω - condMean w X Y (X ω)) * (condMean w X Y (X ω) - mean w Y)) := by
    rw [← Finset.sum_add_distrib, Finset.mul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl (fun ω _ => ?_)
    ring
  rw [expand, hcross, mul_zero]

lemma within_nonneg (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) (hw : ∀ ω, 0 ≤ w ω) :
    0 ≤ within w X Y := by
  refine Finset.sum_nonneg (fun ω _ => ?_)
  exact mul_nonneg (hw ω) (sq_nonneg _)

lemma between_nonneg (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) (hw : ∀ ω, 0 ≤ w ω) :
    0 ≤ between w X Y := by
  refine Finset.sum_nonneg (fun ω _ => ?_)
  exact mul_nonneg (hw ω) (sq_nonneg _)

lemma variance_nonneg (w Y : Ω → ℝ) (hw : ∀ ω, 0 ≤ w ω) :
    0 ≤ variance w Y := by
  refine Finset.sum_nonneg (fun ω _ => ?_)
  exact mul_nonneg (hw ω) (sq_nonneg _)

/-- The within-group variance never exceeds the total variance. -/
lemma within_le_variance [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    within w X Y ≤ variance w Y := by
  rw [total_variance w X Y hw]
  linarith [between_nonneg w X Y hw]

/-- The between-group variance never exceeds the total variance. -/
lemma between_le_variance [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    between w X Y ≤ variance w Y := by
  rw [total_variance w X Y hw]
  linarith [within_nonneg w X Y hw]

end ChapterTotalVariance
