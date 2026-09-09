import Mathlib

/-!
# Chapter E (continued) — Euler's formula for a *generic* phase-space

This file formalizes the **generic-phase-space** content of the `book.tex`
section *"Euler's formula for a generic phase-space"* (Chapter *"Wave-function
collapse versus Euler's formula"*, `book.tex` line ~3565), complementing:

* `BookProof/ChapterE2.lean` — the stick-breaking *Born probabilities*
  `P(n) = (∏ s²)·c²` (the probability picture), and
* `BookProof/ChapterE3.lean` — the rank-1 density-matrix Euler formula for the
  fixed 2-vector (4-state) case (the density-matrix picture).

The book parametrizes a normalized vector of a separable Hilbert space with a
*countable* orthonormal basis `{lₙ}` by the recursion

```
vₙ = cos(θₙ) · lₙ + sin(θₙ) · vₙ₊₁ ,
```

where `vₙ₊₁` is normalized and orthogonal to `{l₁,…,lₙ}`.  The rank-1 projector
`vₙ vₙ†` then decomposes **recursively** as

```
vₙ vₙ† = cₙ² lₙ lₙ† + sₙ² vₙ₊₁ vₙ₊₁† + cₙ sₙ (lₙ vₙ₊₁† + vₙ₊₁ lₙ†) ,   cₙ = cos θₙ, sₙ = sin θₙ,
```

so *collapse of the wave-function for a generic phase-space is a recursion of
collapses of 2-dimensional real wave-functions*.  Taking the "real part"
(diagonal, in the basis where each `lₙ lₙ†` is diagonal) kills the off-diagonal
cross term, leaving the classical stick-breaking recursion

```
diag(vₙ vₙ†) = cₙ² lₙ lₙ† + sₙ² vₙ₊₁ vₙ₊₁† ,
```

and the conditional probabilities satisfy
`P(n | n or above) + P(n+1 or above | n or above) = cₙ² + sₙ² = 1`, whence total
probability is conserved.

## Model

We take the countable index space to be `ℕ`, the orthonormal basis to be the
standard basis `eₖ = Pi.single k 1 : ℕ → ℝ`, and realize the (finite-support)
recursion terminating after `depth` stick-breaks with base `v = e_{s+depth}`
(`cos = 1`).  Outer products `v v†` are written entrywise as the pointwise
product `v i * v j`.

## Deliverables

* `wave_eq_zero_of_lt` — `vₛ` is supported on indices `≥ s` (orthogonality of the
  tail to the already-measured basis vectors);
* `wave_self_succ` — the leading component is `cos θₛ`;
* `density_recursion` — **headline**: the entrywise density-matrix recursion
  `vₛ vₛ† = cₛ² eₛ eₛ† + sₛ² vₛ₊₁ vₛ₊₁† + cₛ sₛ (eₛ vₛ₊₁† + vₛ₊₁ eₛ†)` (pure
  algebra, no orthonormality);
* `cross_diag_zero` — the Euler cross term `eₛ vₛ₊₁†` has vanishing diagonal;
* `diag_collapse` — "taking the real part": the diagonal obeys the classical
  stick-breaking recursion `(vₛ)ᵢ² = cₛ² (eₛ)ᵢ² + sₛ² (vₛ₊₁)ᵢ²`;
* `cond_prob_sum` — `cₛ² + sₛ² = 1`, the book's
  `P(s | s or above) + P(s+1 or above | s or above) = 1`;
* `wave_prob_sum` — **total probability is conserved**:
  `∑ i ∈ Icc s (s+d), (vₛ)ᵢ² = 1` (the trace of the density matrix is `1`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators

namespace BookProof.ChapterE4

/-- Standard basis column vector `eₖ` in the (countable) index space `ℕ`. -/
def basisVec (k : ℕ) : ℕ → ℝ := Pi.single k 1

/-- Recursive real wave-function of the book's *generic phase-space*:
`vₛ = cos θₛ · eₛ + sin θₛ · vₛ₊₁`, terminating after `depth` stick-breaks with
base `v = e_{s+depth}` (`cos = 1`).  `wave θ s d` is the wave-function whose
leading component is at index `s` and which has `d` remaining stick-breaks. -/
noncomputable def wave (θ : ℕ → ℝ) : ℕ → ℕ → (ℕ → ℝ)
  | s, 0 => basisVec s
  | s, (d + 1) =>
      fun i => Real.cos (θ s) * basisVec s i + Real.sin (θ s) * wave θ (s + 1) d i

@[simp] theorem wave_zero (θ : ℕ → ℝ) (s : ℕ) : wave θ s 0 = basisVec s := rfl

theorem wave_succ (θ : ℕ → ℝ) (s d : ℕ) (i : ℕ) :
    wave θ s (d + 1) i =
      Real.cos (θ s) * basisVec s i + Real.sin (θ s) * wave θ (s + 1) d i := rfl

/-
`(eₖ)ᵢ² = if i = k then 1 else 0`.
-/
theorem basisVec_sq (k i : ℕ) : (basisVec k i) ^ 2 = if i = k then 1 else 0 := by
  unfold basisVec; aesop;

/-
The tail wave-function `vₛ` is supported only on indices `≥ s`: it is
orthogonal to each already-measured basis vector `l₁,…,lₛ`.
-/
theorem wave_eq_zero_of_lt (θ : ℕ → ℝ) (s d i : ℕ) (h : i < s) : wave θ s d i = 0 := by
  induction d generalizing s i with
  | zero => ?_
  | succ d hd => ?_
  · exact Pi.single_eq_of_ne ( ne_of_lt h ) _;
  · rw [ wave_succ ];
    simp [ basisVec, h.ne, hd _ _ ( Nat.lt_succ_of_lt h ) ]

/-
The leading component of `vₛ` (after at least one stick-break) is `cos θₛ`.
-/
theorem wave_self_succ (θ : ℕ → ℝ) (s d : ℕ) :
    wave θ s (d + 1) s = Real.cos (θ s) := by
  -- Unfold one stick-break; the tail contributes nothing at index `s`.
  rw [wave_succ]
  simp only [basisVec, Pi.single_eq_same, mul_one, add_eq_left, mul_eq_zero];
  exact Or.inr ( wave_eq_zero_of_lt _ _ _ _ ( Nat.lt_succ_self _ ) )

/-
**Headline — density-matrix recursion (Euler's formula for a generic
phase-space).**  Entrywise,
`vₛ vₛ† = cₛ² eₛ eₛ† + sₛ² vₛ₊₁ vₛ₊₁† + cₛ sₛ (eₛ vₛ₊₁† + vₛ₊₁ eₛ†)`.
This is a purely algebraic identity, requiring no orthonormality.
-/
theorem density_recursion (θ : ℕ → ℝ) (s d i j : ℕ) :
    wave θ s (d + 1) i * wave θ s (d + 1) j
      = Real.cos (θ s) ^ 2 * (basisVec s i * basisVec s j)
        + Real.sin (θ s) ^ 2 * (wave θ (s + 1) d i * wave θ (s + 1) d j)
        + Real.cos (θ s) * Real.sin (θ s) *
            (basisVec s i * wave θ (s + 1) d j + wave θ (s + 1) d i * basisVec s j) := by
  rw [ wave_succ, wave_succ ] ; ring

/-
The Euler cross term `eₛ vₛ₊₁†` has a vanishing diagonal: `(eₛ)ᵢ · (vₛ₊₁)ᵢ = 0`
for every `i` (if `i = s` then `(vₛ₊₁)ₛ = 0` by orthogonality, else `(eₛ)ᵢ = 0`).
-/
theorem cross_diag_zero (θ : ℕ → ℝ) (s d i : ℕ) :
    basisVec s i * wave θ (s + 1) d i = 0 := by
  by_cases hi : i = s <;> simp only [basisVec, hi, mul_eq_zero, ne_eq, not_false_eq_true,
      Pi.single_eq_of_ne, zero_mul];
  exact Or.inr ( wave_eq_zero_of_lt _ _ _ _ ( Nat.lt_succ_self _ ) )

/-
**Collapse = taking the real part.**  The diagonal of `vₛ vₛ†` obeys the
classical stick-breaking recursion `(vₛ)ᵢ² = cₛ² (eₛ)ᵢ² + sₛ² (vₛ₊₁)ᵢ²`: the
off-diagonal cross term drops out on the diagonal.
-/
theorem diag_collapse (θ : ℕ → ℝ) (s d i : ℕ) :
    (wave θ s (d + 1) i) ^ 2
      = Real.cos (θ s) ^ 2 * (basisVec s i) ^ 2
        + Real.sin (θ s) ^ 2 * (wave θ (s + 1) d i) ^ 2 := by
  grind +suggestions

/-
The book's conditional-probability identity
`P(s | s or above) + P(s+1 or above | s or above) = 1`, i.e. `cₛ² + sₛ² = 1`.
-/
theorem cond_prob_sum (θ : ℕ → ℝ) (s : ℕ) :
    Real.cos (θ s) ^ 2 + Real.sin (θ s) ^ 2 = 1 := by
  exact Real.cos_sq_add_sin_sq _

/-
**Total probability is conserved** (the trace of the density matrix is `1`):
`∑ i ∈ Icc s (s+d), (vₛ)ᵢ² = 1`.  Equivalently `tr(diag(vₛ vₛ†)) = 1`.
-/
theorem wave_prob_sum (θ : ℕ → ℝ) (s d : ℕ) :
    ∑ i ∈ Finset.Icc s (s + d), (wave θ s d i) ^ 2 = 1 := by
  induction d generalizing s with
  | zero => ?_
  | succ d ih => ?_
  · simp [ wave_zero, basisVec ];
  · -- Apply the_diag_collapse theorem to rewrite the sum.
    have h_sum : ∑ i ∈ Finset.Icc s (s + d + 1),      (wave θ s (d + 1) i) ^ 2 = (Real.cos (θ s)) ^
        2 * (∑ i ∈ Finset.Icc s (s + d + 1), (basisVec s i) ^ 2) + (Real.sin (θ s)) ^ 2 * (∑ i ∈
            Finset.Icc s (s + d + 1), (wave θ (s + 1) d i) ^ 2) := by
      rw [ Finset.mul_sum _ _ _, Finset.mul_sum _ _ _, ← Finset.sum_add_distrib ] ;        exact
          Finset.sum_congr rfl fun _ _ => diag_collapse θ s d _;
    -- Evaluate the sums using the properties of the basis vectors and the induction hypothesis.
    have h_basis : ∑ i ∈ Finset.Icc s (s + d + 1), (basisVec s i) ^ 2 = 1 := by
      rw [ Finset.sum_eq_single s ] <;> simp +contextual [ basisVec ];
      linarith
    have h_ind : ∑ i ∈ Finset.Icc s (s + d + 1), (wave θ (s + 1) d i) ^ 2 = 1 := by
      convert ih (s + 1) using 1
      rw [show s + 1 + d = s + d + 1 by ring, Finset.Icc_eq_cons_Ioc (by linarith),
        Finset.sum_cons]
      have hIcc : Finset.Icc (s + 1) (s + d + 1) = Finset.Ioc s (s + d + 1) := by
        ext; aesop
      rw [hIcc, show wave θ (s + 1) d s = 0 from wave_eq_zero_of_lt _ _ _ _ (by linarith)]
      norm_num
    simp_all [← add_assoc]

end BookProof.ChapterE4
