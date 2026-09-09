import Mathlib

/-!
# Chapter E (continued) — Euler's formula for the density matrix

This file formalizes the **density-matrix ("Euler's formula for the corresponding
density matrices")** content of the `book.tex` section *"Euler's formula for a
phase-space with 4 states"* (Chapter *"Wave-function collapse versus Euler's
formula"*, `book.tex` line ~3478), complementing:

* `BookProof/ChapterE.lean` — the 2-state probability clock and the scalar
  `cos²`/rotation core, and
* `BookProof/ChapterE2.lean` — the stick-breaking *Born probabilities*
  `P(n) = (∏ s²)·c²`.

The book writes each collapse step of a real normalized wave-function
`φ = cos θ · l + sin θ · w` (with `l` the "measured" basis vector and `w` the
"remaining" wave-function) as an **Euler's formula for the rank-1 density matrix**
`φφ†`:

```
φφ† = ½(l l† + w w†) + ½ cos(2θ) (l l† − w w†) + ½ sin(2θ) (l w† + w l†)
```

with `J := l w† − w l†` playing the role of the *imaginary unit* in the
2-dimensional subspace `span{l, w}`.  "Collapse = taking the real part" is then
the statement that the diagonal (the classical conditional probability) is the
`cos(2θ)` part, giving `P(l | l or above) = ½ + ½ cos(2θ) = cos²θ`.

We model column vectors as `l w : Fin n → ℝ` and their outer products
`l l†` as `Matrix.vecMulVec l l`.

Deliverables:

* `euler_density_matrix` — **headline**: the density-matrix Euler formula, an
  algebraic identity requiring **no** orthonormality;
* `eulerJ_antisymm` — the "imaginary unit" `J = l w† − w l†` is antisymmetric
  (`Jᵀ = −J`);
* `eulerJ_sq` — under orthonormality `J² = −(l l† + w w†)`, i.e. `J` squares to
  minus the identity of the subspace: it genuinely behaves like `i`;
* `euler_density_diag_real` — "taking the real part": the `l`-diagonal entry of
  `φφ†` is `cos²θ = ½ + ½ cos(2θ)`, the book's conditional probability;
* `euler_density_isIdempotent` — under orthonormality `φφ†` is a genuine rank-1
  projector (`φφ† · φφ† = φφ†`), the density matrix of a pure state.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped Matrix BigOperators

namespace BookProof.ChapterE3

variable {n : ℕ}

/-- The "imaginary unit" of the Euler formula in the subspace `span{l, w}`:
`J = l w† − w l†`. -/
def eulerJ (l w : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.vecMulVec l w - Matrix.vecMulVec w l

/-
**Headline — Euler's formula for the density matrix.**
For a real wave-function `φ = cos θ · l + sin θ · w`, the rank-1 density matrix
`φ φ†` decomposes as
`½(l l† + w w†) + ½ cos(2θ)(l l† − w w†) + ½ sin(2θ)(l w† + w l†)`.
This is a purely algebraic identity (double-angle formulas), requiring no
orthonormality of `l, w`.
-/
theorem euler_density_matrix (l w : Fin n → ℝ) (θ : ℝ) :
    Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i)
      = (1 / 2 : ℝ) • (Matrix.vecMulVec l l + Matrix.vecMulVec w w)
        + (Real.cos (2 * θ) / 2) • (Matrix.vecMulVec l l - Matrix.vecMulVec w w)
        + (Real.sin (2 * θ) / 2) • (Matrix.vecMulVec l w + Matrix.vecMulVec w l) := by
  ext i j
  simp only [Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply,
    smul_eq_mul]
  rw [Real.cos_two_mul, Real.sin_two_mul]
  linear_combination (w i * w j) * (Real.sin_sq_add_cos_sq θ)

/-
The Euler "imaginary unit" `J = l w† − w l†` is antisymmetric: `Jᵀ = −J`.
-/
theorem eulerJ_antisymm (l w : Fin n → ℝ) :
    (eulerJ l w)ᵀ = - eulerJ l w := by
  ext i j; simp [eulerJ];
  simp [ Matrix.vecMulVec, mul_comm ]

/-
Under orthonormality (`⟪l,l⟫ = ⟪w,w⟫ = 1`, `⟪l,w⟫ = 0`), the Euler imaginary
unit squares to minus the identity of the subspace:
`J² = −(l l† + w w†)`.  Thus `J` genuinely plays the role of `i` on `span{l,w}`.
-/
theorem eulerJ_sq (l w : Fin n → ℝ)
    (hll : ∑ i, l i * l i = 1) (hww : ∑ i, w i * w i = 1)
    (hlw : ∑ i, l i * w i = 0) :
    eulerJ l w * eulerJ l w = - (Matrix.vecMulVec l l + Matrix.vecMulVec w w) := by
  unfold eulerJ
  -- The product of two outer products collapses to a scalar multiple of one:
  -- `(a b†)(c d†) = ⟪ b, c⟫ • (a d†)`.
  have h_mul : ∀ (a b c d : Fin n → ℝ),
      Matrix.vecMulVec a b * Matrix.vecMulVec c d = (∑ i, b i * c i) • Matrix.vecMulVec a d := by
    intro a b c d
    ext i j
    simp only [Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.smul_apply, smul_eq_mul,
      Finset.sum_mul]
    exact Finset.sum_congr rfl (fun k _ => by ring)
  have hwl : ∑ i, w i * l i = 0 := by simpa [mul_comm] using hlw
  simp only [Matrix.sub_mul, Matrix.mul_sub, h_mul, hll, hww, hlw, hwl, zero_smul, one_smul]
  abel

/-
**"Taking the real part."** The `l`-diagonal entry of the density matrix
`φ φ†` (with `φ = cos θ · l + sin θ · w`) is, under orthonormality,
`cos²θ = ½ + ½ cos(2θ)` — the book's conditional probability
`P(l | l or above)`.
-/
theorem euler_density_diag_real (l w : Fin n → ℝ) (θ : ℝ) (i : Fin n)
    (hli : l i = 1) (hwi : w i = 0) :
    Matrix.vecMulVec (fun j => Real.cos θ * l j + Real.sin θ * w j)
        (fun j => Real.cos θ * l j + Real.sin θ * w j) i i
      = Real.cos θ ^ 2 := by
  simp [ Matrix.vecMulVec, hli, hwi, sq ]

/-
Under orthonormality, the density matrix `φ φ†` of the normalized
wave-function `φ = cos θ · l + sin θ · w` is a genuine rank-1 projector
(idempotent): `(φ φ†)(φ φ†) = φ φ†`.  This is the density matrix of a pure
state.
-/
theorem euler_density_isIdempotent (l w : Fin n → ℝ) (θ : ℝ)
    (hll : ∑ i, l i * l i = 1) (hww : ∑ i, w i * w i = 1)
    (hlw : ∑ i, l i * w i = 0) :
    (Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i))
      * (Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i))
      = Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i) := by
  have h_sum : ∑ i, (Real.cos θ * l i + Real.sin θ * w i)
      * (Real.cos θ * l i + Real.sin θ * w i) = 1 := by
    ring_nf
    simp_all [Finset.sum_add_distrib, mul_assoc, mul_comm, mul_left_comm,
      Real.sin_sq, Real.cos_sq]
    ring
    simp_all [Finset.sum_add_distrib, ← Finset.mul_sum _ _ _, ← Finset.sum_mul, sq]
    ring
  convert congr_arg (fun x : ℝ => x • Matrix.vecMulVec
    (fun i => Real.cos θ * l i + Real.sin θ * w i)
    (fun i => Real.cos θ * l i + Real.sin θ * w i)) h_sum using 1
  · ext i j
    simp [Matrix.vecMulVec, Matrix.mul_apply, Finset.mul_sum _ _ _,
      mul_comm, mul_left_comm]
  · norm_num

end BookProof.ChapterE3
