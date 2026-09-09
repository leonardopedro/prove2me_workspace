import Mathlib
import BookProof.ChapterObservableExpectation

/-!
# Chapter "The Coherent State of Attention", §"The Posterior: Observable
Operators and Expectation Values" — the observable as an **operator**

`BookProof.ChapterObservableExpectation` proves the expectation-value identity
using only the *spectral data* of the observable (its eigenvalues `vⱼ` indexed by
the outcomes) and records the disparity with the informal chapter, which writes
the observable as the operator

  `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|`

and appeals to the spectral theorem.  This module closes that disparity by
building the operator itself, in finite dimensions, as a matrix:

* `outerProj k` — the rank-one operator `|k⟩⟨k|`;
* `observableOp k v` — the observable `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|` with real eigenvalues;
* `observableOp_isHermitian` — **`V̂` is Hermitian** (a genuine observable);
* `bornProb` — the Born statistics `pⱼ = |⟨kⱼ|q⟩|²` of measuring `V̂` in the state
  `|q⟩`, with `bornProb_nonneg` and (for an orthonormal eigenbasis and a unit
  state) `bornProb_sum_one`;
* `expectation_outerProj`, **`observableOp_expectation`** — the operator
  expectation `⟨q|V̂|q⟩` is the Born-weighted sum `∑ⱼ pⱼ vⱼ` of the eigenvalues,
  i.e. exactly `ChapterObservableExpectation.observableExpectation`;
* `observableOp_expectation_mem_convexHull` — hence, for an orthonormal
  eigenbasis and a unit state, the expectation lies in the convex hull of the
  eigenvalues;
* `observableOp_expectation_real` — the expectation of a Hermitian observable is
  real.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterObservableOperator

variable {n m : ℕ}

/-! ## The observable operator -/

/-- The rank-one operator `|k⟩⟨k|`, as a matrix. -/
def outerProj (k : EuclideanSpace ℂ (Fin n)) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun a b => k a * (starRingEnd ℂ) (k b)

/-- The **observable** `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|` with eigenvectors `kⱼ` and real
eigenvalues `vⱼ`. -/
def observableOp (k : Fin m → EuclideanSpace ℂ (Fin n)) (v : Fin m → ℝ) :
    Matrix (Fin n) (Fin n) ℂ :=
  ∑ j, (v j : ℂ) • outerProj (k j)

/-- Each rank-one projector `|k⟩⟨k|` is Hermitian. -/
theorem outerProj_isHermitian (k : EuclideanSpace ℂ (Fin n)) :
    (outerProj k).IsHermitian := by
  ext a b
  simp [outerProj, Matrix.conjTranspose_apply, mul_comm]

/-- **The observable is Hermitian** whenever its eigenvalues are real: `V̂ᴴ = V̂`.
-/
theorem observableOp_isHermitian (k : Fin m → EuclideanSpace ℂ (Fin n)) (v : Fin m → ℝ) :
    (observableOp k v).IsHermitian := by
  unfold Matrix.IsHermitian observableOp
  rw [Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Matrix.conjTranspose_smul]
  simp [outerProj_isHermitian (k j), Matrix.IsHermitian.eq]

/-! ## Expectation values -/

/-- The **expectation value** `⟨q| A |q⟩` of a matrix observable in the state
`|q⟩`. -/
def expectation (A : Matrix (Fin n) (Fin n) ℂ) (q : EuclideanSpace ℂ (Fin n)) : ℂ :=
  ∑ a, ∑ b, (starRingEnd ℂ) (q a) * A a b * q b

/-- The **Born probability** of the outcome `j`: `pⱼ = |⟨kⱼ|q⟩|²`. -/
def bornProb (k : Fin m → EuclideanSpace ℂ (Fin n)) (q : EuclideanSpace ℂ (Fin n))
    (j : Fin m) : ℝ := ‖(inner ℂ (k j) q : ℂ)‖ ^ 2

theorem bornProb_nonneg (k : Fin m → EuclideanSpace ℂ (Fin n))
    (q : EuclideanSpace ℂ (Fin n)) (j : Fin m) : 0 ≤ bornProb k q j := sq_nonneg _

/-- The expectation of a rank-one projector is the Born probability of the
corresponding outcome: `⟨q| |k⟩⟨k| |q⟩ = |⟨k|q⟩|²`. -/
theorem expectation_outerProj (k q : EuclideanSpace ℂ (Fin n)) :
    expectation (outerProj k) q = ((‖(inner ℂ k q : ℂ)‖ ^ 2 : ℝ) : ℂ) := by
  have hq : ∀ x y : EuclideanSpace ℂ (Fin n),
      (inner ℂ x y : ℂ) = ∑ i, (starRingEnd ℂ) (x i) * y i := by
    intro x y
    rw [PiLp.inner_apply]
    simp [RCLike.inner_apply, mul_comm]
  have hsplit : expectation (outerProj k) q
      = (∑ a, (starRingEnd ℂ) (q a) * k a) * (∑ b, (starRingEnd ℂ) (k b) * q b) := by
    rw [expectation, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    simp only [outerProj, Matrix.of_apply]
    ring
  rw [hsplit, ← hq q k, ← hq k q, ← inner_conj_symm k q,
    ← Complex.normSq_eq_norm_sq, Complex.normSq_eq_conj_mul_self]
  simp

/-- **The operator expectation is the Born-weighted sum of the eigenvalues.**
This is the chapter's `⟨V̂⟩ = ∑ⱼ pⱼ vⱼ`, now for the genuine operator
`V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|`. -/
theorem observableOp_expectation (k : Fin m → EuclideanSpace ℂ (Fin n)) (v : Fin m → ℝ)
    (q : EuclideanSpace ℂ (Fin n)) :
    expectation (observableOp k v) q
      = ((BookProof.ChapterObservableExpectation.observableExpectation
            (bornProb k q) v : ℝ) : ℂ) := by
  have key : ∀ a b : Fin n, (starRingEnd ℂ) (q a) * (observableOp k v) a b * q b
      = ∑ j, (v j : ℂ) * ((starRingEnd ℂ) (q a) * outerProj (k j) a b * q b) := by
    intro a b
    simp only [observableOp, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul,
      Finset.mul_sum, Finset.sum_mul]
    exact Finset.sum_congr rfl fun j _ => by ring
  have hlin : expectation (observableOp k v) q
      = ∑ j, (v j : ℂ) * expectation (outerProj (k j)) q :=
    calc expectation (observableOp k v) q
        = ∑ a, ∑ b, ∑ j, (v j : ℂ) * ((starRingEnd ℂ) (q a) * outerProj (k j) a b * q b) := by
          simp only [expectation, key]
      _ = ∑ a, ∑ j, ∑ b, (v j : ℂ) * ((starRingEnd ℂ) (q a) * outerProj (k j) a b * q b) :=
          Finset.sum_congr rfl fun a _ => Finset.sum_comm
      _ = ∑ j, ∑ a, ∑ b, (v j : ℂ) * ((starRingEnd ℂ) (q a) * outerProj (k j) a b * q b) :=
          Finset.sum_comm
      _ = ∑ j, (v j : ℂ) * expectation (outerProj (k j)) q := by
          simp only [expectation, Finset.mul_sum]
  rw [hlin, BookProof.ChapterObservableExpectation.observableExpectation_scalar]
  push_cast
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [expectation_outerProj]
  simp [bornProb, mul_comm]

/-- The expectation value of a Hermitian observable is a **real** number. -/
theorem observableOp_expectation_real (k : Fin m → EuclideanSpace ℂ (Fin n))
    (v : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    (expectation (observableOp k v) q).im = 0 := by
  rw [observableOp_expectation]
  simp

/-! ## An orthonormal eigenbasis makes the Born statistics a probability law -/

/-- **Born normalization.**  If the eigenvectors form an orthonormal basis and the
state is a unit vector, the Born probabilities sum to one (Parseval). -/
theorem bornProb_sum_one (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n)))
    (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    ∑ j, bornProb (fun j => b j) q j = 1 := by
  simpa [bornProb, hq] using b.sum_sq_norm_inner_right q

/-- **The expectation value of an observable lies in the convex hull of its
eigenvalues**: measuring `V̂` in a unit state returns, on average, a value between
the smallest and the largest eigenvalue. -/
theorem observableOp_expectation_mem_convexHull
    (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n))) (v : Fin m → ℝ)
    (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    BookProof.ChapterObservableExpectation.observableExpectation
        (bornProb (fun j => b j) q) v ∈ convexHull ℝ (Set.range v) :=
  BookProof.ChapterObservableExpectation.prob_weighted_sum_mem_convexHull _
    (fun j => bornProb_nonneg _ q j) (bornProb_sum_one b q hq) v

/-- **The operator form of the chapter's identity.**  For an orthonormal
eigenbasis of keys and a unit query state, the Born statistics `pⱼ = |⟨kⱼ|q⟩|²`
are a probability distribution and the expectation value of the observable
`V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|` in that state is exactly the probability-weighted sum of the
eigenvalues. -/
theorem observable_expectation_born (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n)))
    (v : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    (∀ j, 0 ≤ bornProb (fun j => b j) q j) ∧
      (∑ j, bornProb (fun j => b j) q j = 1) ∧
      expectation (observableOp (fun j => b j) v) q
        = ((∑ j, bornProb (fun j => b j) q j * v j : ℝ) : ℂ) :=
  ⟨fun j => bornProb_nonneg _ q j, bornProb_sum_one b q hq, by
    rw [observableOp_expectation,
      BookProof.ChapterObservableExpectation.observableExpectation_scalar]⟩

end BookProof.ChapterObservableOperator

end
