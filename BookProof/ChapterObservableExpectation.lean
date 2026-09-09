import Mathlib
import BookProof.ChapterSoftmaxBorn
import BookProof.ChapterBayesInference

/-!
# Chapter "The Coherent State of Attention", §"The Posterior: Observable
Operators and Expectation Values"

Formalization of the third identity of the new chapter `Book/CoherentState.lean`:
the attention output

  `oᵢ = ∑ⱼ aᵢⱼ vⱼ`

is the **expectation value of a contextual observable** over the posterior
produced by the Born-rule measurement of the previous section.  By the spectral
theorem an observable is fixed by its eigenstates (the keys `|kⱼ⟩`) and its
eigenvalues (the values `vⱼ`), and its expectation value in a state whose Born
statistics are `pⱼ` is the probability-weighted sum `∑ⱼ pⱼ vⱼ`.

The mathematical core is finite and purely algebraic: it is the statement that
the attention output *is* a convex combination — an expectation — of the value
vectors, together with the fact that the weights produced in
`ChapterSoftmaxBorn` are a genuine probability distribution.

Deliverables (all `sorry`-free, `axiom`-free):

* `observableExpectation` — the probability-weighted sum `∑ⱼ pⱼ • vⱼ`;
* `observableExpectation_scalar` — for scalar eigenvalues it is the ordinary
  expectation `∑ⱼ pⱼ vⱼ`, matching `ChapterConditional` / `ChapterBayesInference`;
* `observableExpectation_const` — a sharp observable has its own value as
  expectation (normalization of the distribution);
* `observableExpectation_add`, `observableExpectation_smul` — linearity in the
  eigenvalues, the defining property of an expectation value;
* `prob_weighted_sum_mem_convexHull` — the expectation lies in the convex hull of
  the eigenvalues: measurement never leaves the span of the possible outcomes;
* `observableExpectation_norm_le` — and it is bounded by the largest eigenvalue
  norm;
* **HEADLINE `attention_eq_expectation`** — the Softmax/Born attention output is
  exactly the expectation value of the value-observable over the coherent-state
  Born posterior, and that posterior is a genuine probability distribution;
* `attention_mem_convexHull` — hence the attention output is a convex combination
  of the value vectors;
* `bayes_posterior_expectation_mem_convexHull` — the same packaging for the Bayes
  posterior of `ChapterBayesInference`, exhibiting the deep-learning layer as one
  complete Bayesian update.

**Recorded disparity with the informal chapter.**  The chapter writes the
observable as an operator `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|` and appeals to the spectral
theorem.  Here the observable is represented by its *spectral data* — the family
of eigenvalues `v : Fin m → E` indexed by the outcomes — and the theorem proved
is the expectation-value identity for that data.  Building the operator `V̂`
itself (and proving that the coherent states `|kⱼ⟩` are orthonormal, which they
are *not* — coherent states are overcomplete) is deliberately not attempted here;
the chapter's step is exactly the finite expectation identity formalized below.
**This disparity is now closed** by `BookProof.ChapterObservableOperator`, which
builds the operator `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|` as a matrix, proves it Hermitian for real
eigenvalues, and proves the operator expectation `⟨q|V̂|q⟩ = ∑ⱼ pⱼ vⱼ` with the Born
statistics `pⱼ = |⟨kⱼ|q⟩|²` (a probability distribution for an orthonormal
eigenbasis and a unit state).

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterObservableExpectation

open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-! ## The expectation value of an observable -/

/-- The **expectation value** of an observable with eigenvalues `v : Fin m → E`
in a state whose measurement statistics over the eigenbasis are `p : Fin m → ℝ`:
the probability-weighted sum `⟨V̂⟩ = ∑ⱼ pⱼ vⱼ`. -/
def observableExpectation (p : Fin m → ℝ) (v : Fin m → E) : E := ∑ j, p j • v j

/-- For a scalar-valued observable the expectation value is the ordinary
expectation `∑ⱼ pⱼ vⱼ` of probability theory. -/
theorem observableExpectation_scalar (p v : Fin m → ℝ) :
    observableExpectation p v = ∑ j, p j * v j := by
  simp [observableExpectation, smul_eq_mul]

/-- A **sharp** observable — one whose eigenvalue is the same on every outcome —
has that value as its expectation, for any probability distribution. -/
theorem observableExpectation_const (p : Fin m → ℝ) (hp : ∑ j, p j = 1) (c : E) :
    observableExpectation p (fun _ => c) = c := by
  rw [observableExpectation, ← Finset.sum_smul, hp, one_smul]

/-- Expectation is additive in the observable. -/
theorem observableExpectation_add (p : Fin m → ℝ) (v w : Fin m → E) :
    observableExpectation p (fun j => v j + w j)
      = observableExpectation p v + observableExpectation p w := by
  simp [observableExpectation, smul_add, Finset.sum_add_distrib]

/-- Expectation is homogeneous in the observable. -/
theorem observableExpectation_smul (p : Fin m → ℝ) (c : ℝ) (v : Fin m → E) :
    observableExpectation p (fun j => c • v j) = c • observableExpectation p v := by
  rw [observableExpectation, observableExpectation, Finset.smul_sum]
  exact Finset.sum_congr rfl fun j _ => smul_comm (p j) c (v j)

/-- Expectation is additive in the state (the distribution). -/
theorem observableExpectation_add_left (p q : Fin m → ℝ) (v : Fin m → E) :
    observableExpectation (fun j => p j + q j) v
      = observableExpectation p v + observableExpectation q v := by
  simp [observableExpectation, add_smul, Finset.sum_add_distrib]

/-! ## The expectation is a convex combination of the outcomes -/

/-- **The expectation value lies in the convex hull of the eigenvalues.**  A
measurement returns a definite vector, but never one outside the range of the
possible outcomes. -/
theorem prob_weighted_sum_mem_convexHull (p : Fin m → ℝ) (hp : ∀ j, 0 ≤ p j)
    (hp1 : ∑ j, p j = 1) (v : Fin m → E) :
    observableExpectation p v ∈ convexHull ℝ (Set.range v) := by
  refine (convex_convexHull ℝ (Set.range v)).sum_mem (fun j _ => hp j) hp1 ?_
  intro j _
  exact subset_convexHull ℝ (Set.range v) ⟨j, rfl⟩

/-- In a normed space the expectation value is bounded by the largest eigenvalue
norm. -/
theorem observableExpectation_norm_le {F : Type*} [NormedAddCommGroup F]
    [NormedSpace ℝ F] (p : Fin m → ℝ) (hp : ∀ j, 0 ≤ p j) (hp1 : ∑ j, p j = 1)
    (v : Fin m → F) (C : ℝ) (hC : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation p v‖ ≤ C := by
  calc ‖observableExpectation p v‖ ≤ ∑ j, ‖p j • v j‖ := norm_sum_le _ _
    _ = ∑ j, p j * ‖v j‖ := by
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg (hp j)]
    _ ≤ ∑ j, p j * C :=
        Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_left (hC j) (hp j)
    _ = C := by rw [← Finset.sum_mul, hp1, one_mul]

/-! ## The attention output is an expectation value -/

/-- The **attention output** of a query against keys `k` with value vectors `v`:
the Born-weighted aggregation `oᵢ = ∑ⱼ aᵢⱼ vⱼ`. -/
def attentionOutput (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (v : Fin m → E) : E :=
  ∑ j, bornWeight q k j • v j

/-- **HEADLINE — the attention output is the expectation value of a contextual
observable over the collapsed posterior.**

The coherent-state Born weights are a genuine probability distribution over the
keys (nonnegative, summing to one), and the attention aggregation of the value
vectors is *by definition* the expectation value of the observable whose
eigenstates are the keys and whose eigenvalues are the values. -/
theorem attention_eq_expectation (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (j₀ : Fin m) :
    (∀ j, 0 ≤ bornWeight q k j) ∧ (∑ j, bornWeight q k j = 1) ∧
      attentionOutput q k v = observableExpectation (bornWeight q k) v :=
  ⟨fun j => bornWeight_nonneg q k j, bornWeight_sum_one q k j₀, rfl⟩

/-- The attention output is a convex combination of the value vectors: a
*definite* vector in the hull of the contextual outcomes. -/
theorem attention_mem_convexHull (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (j₀ : Fin m) :
    attentionOutput q k v ∈ convexHull ℝ (Set.range v) :=
  prob_weighted_sum_mem_convexHull _ (fun j => bornWeight_nonneg q k j)
    (bornWeight_sum_one q k j₀) v

/-- With normalized keys, the attention output is the expectation value over the
*Softmax* posterior — the two descriptions of the same layer coincide. -/
theorem attention_eq_softmax_expectation (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r)
    (v : Fin m → E) :
    attentionOutput q k v = observableExpectation (softmax 2 q k) v := by
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [coherentBorn_eq_softmax q k r hk j]

/-! ## The same packaging for the Bayes posterior -/

open BookProof.ChapterBayesInference

variable {Y : Type*}

/-- The Bayes posterior is nonnegative (the `ChapterBayesInference` fact, restated
without the ambient finiteness instances on the data type, which the statement
does not need). -/
theorem bayesPosterior_nonneg {prior : Fin m → ℝ} {L : Fin m → Y → ℝ}
    (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y) (y : Y) (x : Fin m) :
    0 ≤ posterior prior L y x :=
  div_nonneg (mul_nonneg (hprior x) (hL x y))
    (Finset.sum_nonneg fun _ _ => mul_nonneg (hprior _) (hL _ _))

/-- The Bayes posterior sums to one whenever the evidence is positive. -/
theorem bayesPosterior_sum_one {prior : Fin m → ℝ} {L : Fin m → Y → ℝ} (y : Y)
    (hy : 0 < evidence prior L y) : ∑ x, posterior prior L y x = 1 := by
  have h : ∑ x, posterior prior L y x = evidence prior L y / evidence prior L y := by
    simp [posterior, evidence, Finset.sum_div]
  rw [h, div_self hy.ne']

/-- The expectation of an observable over the **Bayes posterior** of
`ChapterBayesInference` is again a convex combination of the eigenvalues: one
attention layer, read as one complete Bayesian update, returns a definite vector
inside the hull of the contextual meanings. -/
theorem bayes_posterior_expectation_mem_convexHull
    (prior : Fin m → ℝ) (L : Fin m → Y → ℝ) (y : Y)
    (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (hy : 0 < evidence prior L y) (v : Fin m → E) :
    observableExpectation (posterior prior L y) v ∈ convexHull ℝ (Set.range v) :=
  prob_weighted_sum_mem_convexHull _
    (fun x => bayesPosterior_nonneg hprior hL y x) (bayesPosterior_sum_one y hy) v

end BookProof.ChapterObservableExpectation

end
