import Mathlib
import BookProof.ChapterJointUnitary

/-!
# Chapter "Wave-function parametrization of a probability measure", §2 —
Unitary inference reproduces Bayesian inference

Formalization of the self-contained finite-dimensional core of the book's central
§2 compatibility claim (`book.tex` line ~1338, chapter *"Wave-function
parametrization of a probability measure"*):

> "given a Bayesian model, a prior probability and data that allows to produce a
> posterior probability through Bayesian inference, there is a reversible model
> that produces the same posterior probability as a function of the prior
> probability."

A finite **Bayesian model** is a prior distribution `prior : X → ℝ` on the
hypotheses/parameters together with a likelihood / Markov kernel
`L : X → Y → ℝ` (each row `y ↦ L x y` a probability distribution on the data
`Y`).  Observing data `y`, the **Bayes posterior** is
`posterior y x = prior x · L x y / evidence y`, where
`evidence y = ∑_x prior x · L x y` is the marginal likelihood of the data.

The book's *reversible* (unitary) model reproduces this posterior via the **Born
rule**: the joint density `p(x,y) = prior x · L x y` is `|Ψ(x,y)|²` for the
normalized wave-function `Ψ = √p`, which — by the §3 Gram–Schmidt construction
(`ChapterJointUnitary.exists_unitary_joint`) — is a column of a *unitary* matrix
`U` on `L²(X × Y)`.  Conditioning that column on the observed data (Born-rule
conditioning) returns exactly the Bayes posterior.

Deliverables (all `sorry`-free, `axiom`-free):

* `joint_nonneg`, `joint_sum_one` — the joint density `p(x,y) = prior x · L x y`
  is a genuine probability distribution on `X × Y`;
* `evidence_eq_marginal`, `evidence_nonneg` — the evidence is the `X`-marginal;
* `posterior_nonneg`, `posterior_sum_one` — for data `y` with positive evidence
  the Bayes posterior is a probability distribution on `X`;
* `posterior_eq_joint_div_evidence` — the defining Bayes chain rule
  `posterior y x · evidence y = p(x,y)`;
* **`posterior_eq_born_conditional`** — the posterior equals the Born-rule
  conditional `|Ψ(x,y)|² / ∑_{x'} |Ψ(x',y)|²` of the wave-function `Ψ = √p`;
* **`exists_unitary_reproduces_posterior`** (headline) — there is a *unitary*
  matrix `U` on `X × Y` and a column index `i₀` with `‖U (x,y) i₀‖² = p(x,y)`
  such that for every data point `y` with positive evidence, the Bayes posterior
  is reproduced by Born-rule conditioning of that column:
  `posterior y x = ‖U (x,y) i₀‖² / ∑_{x'} ‖U (x',y) i₀‖²`.
-/

open scoped BigOperators

namespace BookProof.ChapterBayesInference

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

/-- The joint probability density `p(x,y) = prior(x) · L(x,y)` of hypothesis `x`
and data `y`. -/
def joint (prior : X → ℝ) (L : X → Y → ℝ) (x : X) (y : Y) : ℝ := prior x * L x y

/-- The evidence (marginal likelihood) `∑_x prior(x) · L(x,y)` of the data `y`. -/
def evidence (prior : X → ℝ) (L : X → Y → ℝ) (y : Y) : ℝ := ∑ x, prior x * L x y

/-- The Bayes posterior `p(x | y) = prior(x) · L(x,y) / evidence(y)`. -/
noncomputable def posterior (prior : X → ℝ) (L : X → Y → ℝ) (y : Y) (x : X) : ℝ :=
  prior x * L x y / evidence prior L y

variable {prior : X → ℝ} {L : X → Y → ℝ}

omit [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem joint_nonneg (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (x : X) (y : Y) : 0 ≤ joint prior L x y := by
  exact mul_nonneg ( hprior x ) ( hL x y )

omit [DecidableEq X] [DecidableEq Y] in
theorem joint_sum_one (hprior_sum : ∑ x, prior x = 1) (hL_row : ∀ x, ∑ y, L x y = 1) :
    ∑ x, ∑ y, joint prior L x y = 1 := by
  simp_all [ joint, ← Finset.mul_sum _ _ _ ]

omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem evidence_eq_marginal (y : Y) : evidence prior L y = ∑ x, joint prior L x y := by
  rfl

omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem evidence_nonneg (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y) (y : Y) :
    0 ≤ evidence prior L y := by
  exact Finset.sum_nonneg fun x _ => mul_nonneg ( hprior x ) ( hL x y )

omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem posterior_nonneg (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (y : Y) (x : X) : 0 ≤ posterior prior L y x := by
  exact div_nonneg ( mul_nonneg ( hprior x ) ( hL x y ) ) ( Finset.sum_nonneg fun _ _ => mul_nonneg
      ( hprior _ ) ( hL _ _ ) )

omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
/-
The Bayes chain rule: posterior times evidence recovers the joint density.
-/
theorem posterior_eq_joint_div_evidence (y : Y) (x : X) :
    posterior prior L y x = joint prior L x y / evidence prior L y := by
  rfl

omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
/-
For data `y` with positive evidence the Bayes posterior is a probability
distribution on the hypotheses `X`.
-/
theorem posterior_sum_one (y : Y) (hy : 0 < evidence prior L y) :
    ∑ x, posterior prior L y x = 1 := by
  convert div_self hy.ne';
  unfold posterior evidence; simp [ Finset.sum_div _ _ _ ] ;

omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
/-
**Born-rule reproduction of the Bayes posterior.** With the wave-function
`Ψ = √p` (`Ψ(x,y) = Real.sqrt (joint prior L x y)`), the Bayes posterior of the
data `y` equals the Born-rule conditional `|Ψ(x,y)|² / ∑_{x'} |Ψ(x',y)|²`.
-/
theorem posterior_eq_born_conditional (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (y : Y) (x : X) :
    posterior prior L y x =
      (Real.sqrt (joint prior L x y)) ^ 2 / ∑ x', (Real.sqrt (joint prior L x' y)) ^ 2 := by
  rw [ posterior_eq_joint_div_evidence, Finset.sum_congr rfl fun _ _ => Real.sq_sqrt (
      by unfold joint; exact mul_nonneg ( hprior _ ) ( hL _ _ ) ) ];
  rw [ Real.sq_sqrt ( by exact mul_nonneg ( hprior x ) ( hL x y ) ) ] ; rfl

/-
**Headline: unitary inference reproduces Bayesian inference.** Given a finite
Bayesian model — a prior `prior` and a likelihood `L` — there is a *unitary*
matrix `U` on `L²(X × Y)` and a column index `i₀` with `‖U (x,y) i₀‖² = p(x,y)`,
such that for every data point `y` with positive evidence the Bayes posterior is
reproduced by Born-rule conditioning of that column of `U`.
-/
theorem exists_unitary_reproduces_posterior
    (hprior : ∀ x, 0 ≤ prior x) (hprior_sum : ∑ x, prior x = 1)
    (hL : ∀ x y, 0 ≤ L x y) (hL_row : ∀ x, ∑ y, L x y = 1)
    (i₀ : X × Y) :
    ∃ U : Matrix (X × Y) (X × Y) ℂ, U ∈ Matrix.unitaryGroup (X × Y) ℂ ∧
      (∀ x y, ‖U (x, y) i₀‖ ^ 2 = joint prior L x y) ∧
      ∀ y, 0 < evidence prior L y → ∀ x,
        posterior prior L y x =
          ‖U (x, y) i₀‖ ^ 2 / ∑ x', ‖U (x', y) i₀‖ ^ 2 := by
  have h_unitary_joint := BookProof.ChapterJointUnitary.exists_unitary_joint (fun x y => joint prior
      L x y) (fun x y => joint_nonneg hprior hL x y) (joint_sum_one hprior_sum hL_row) i₀;
  obtain ⟨ U, hU₁, hU₂ ⟩ := h_unitary_joint; use U; aesop;

end BookProof.ChapterBayesInference
