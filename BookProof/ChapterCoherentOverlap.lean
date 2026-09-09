import Mathlib

/-!
# Chapter "The Coherent State of Attention", §"The Geometry of the Wave-packet" —
the coherent-state overlap is the Gaussian reproducing kernel

Formalization of the first identity of the new chapter `Book/CoherentState.lean`
(adapted from `coherent.md`).  Each query/key vector `q, k` is the parameter of a
*coherent state* `|q⟩, |k⟩` of a bosonic mode; the Bargmann–Fock reproducing
kernel gives the overlap

  `⟨q | k⟩ = exp (-‖q‖²/2 - ‖k‖²/2 + ⟪q, k⟫)`.

This module works over `EuclideanSpace ℝ (Fin n)` (the *real* coherent-state
parameters, where the overlap is a positive real number — the general complex
Bargmann kernel carries an extra phase `exp (i · Im ⟪q,k⟫)` which is invisible to
the Born rule of the next chapter section).  That restriction is no longer a gap:
`BookProof.ChapterCoherentOverlapComplex` formalizes the complex kernel, its
modulus/phase factorization, and the fact (`coherentOverlapC_ofReal`) that the
real kernel below is exactly its restriction to real parameters.

Deliverables (all `sorry`-free, `axiom`-free):

* `coherentOverlap` — the overlap, as a real-valued function of two vectors;
* `coherentOverlap_eq` — the explicit coordinate (sum) formula;
* `coherentOverlap_eq_gaussian` — **the reproducing kernel is a Gaussian**:
  `⟨q|k⟩ = exp (-‖q - k‖²/2)`; the "baseline" terms `-‖q‖²/2, -‖k‖²/2` and the
  alignment term `⟪q,k⟫` recombine into (minus one half) the squared distance;
* `coherentOverlap_pos`, `coherentOverlap_le_one` — the overlap is a positive
  real number, never exceeding `1`;
* `coherentOverlap_self`, `coherentOverlap_unit` — a coherent state is
  normalized: `⟨q|q⟩ = 1`, in particular for a unit vector;
* `coherentOverlap_comm` — symmetry of the kernel;
* `coherentOverlap_eq_one_iff` — the overlap saturates exactly on the diagonal.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterCoherentOverlap

variable {n : ℕ}

/-- The **coherent-state overlap** of two real coherent-state parameters,
i.e. the Bargmann–Fock reproducing kernel evaluated at `(q, k)`:
`⟨q | k⟩ = exp (-‖q‖²/2 - ‖k‖²/2 + ⟪q, k⟫)`. -/
def coherentOverlap (q k : EuclideanSpace ℝ (Fin n)) : ℝ :=
  Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + inner ℝ q k)

/-! ## Coordinate identities -/

/-- The squared Euclidean norm is the sum of squared coordinates. -/
theorem norm_sq_eq_sum (q : EuclideanSpace ℝ (Fin n)) :
    ‖q‖ ^ 2 = ∑ i, q i * q i := by
  rw [← real_inner_self_eq_norm_sq, PiLp.inner_apply]
  simp [sq]

/-- The real inner product is the coordinate dot product. -/
theorem inner_eq_sum (q k : EuclideanSpace ℝ (Fin n)) :
    inner ℝ q k = ∑ i, q i * k i := by
  rw [PiLp.inner_apply]
  simp [mul_comm]

/-- The polarization identity `‖q - k‖² = ‖q‖² + ‖k‖² - 2⟪q,k⟫`. -/
theorem norm_sub_sq_expand (q k : EuclideanSpace ℝ (Fin n)) :
    ‖q - k‖ ^ 2 = ‖q‖ ^ 2 + ‖k‖ ^ 2 - 2 * inner ℝ q k := by
  rw [← real_inner_self_eq_norm_sq, ← real_inner_self_eq_norm_sq,
    ← real_inner_self_eq_norm_sq, inner_sub_sub_self]
  ring_nf
  rw [real_inner_comm k q]
  ring

/-- **The explicit coordinate formula for the overlap.** -/
theorem coherentOverlap_eq (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k =
      Real.exp (-(∑ i, q i * q i) / 2 - (∑ i, k i * k i) / 2 + ∑ i, q i * k i) := by
  rw [coherentOverlap, norm_sq_eq_sum, norm_sq_eq_sum, inner_eq_sum]

/-! ## The overlap is a Gaussian -/

/-- **The coherent overlap is the Gaussian reproducing kernel.**  The two
"baseline" penalties `-‖q‖²/2`, `-‖k‖²/2` and the alignment reward `⟪q,k⟫`
recombine into minus one half the squared distance, so the Bargmann–Fock kernel
on real parameters *is* the Gaussian kernel. -/
theorem coherentOverlap_eq_gaussian (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = Real.exp (-‖q - k‖ ^ 2 / 2) := by
  rw [coherentOverlap, norm_sub_sq_expand]
  ring_nf

/-! ## Basic properties -/

/-- The overlap of two real coherent states is strictly positive. -/
theorem coherentOverlap_pos (q k : EuclideanSpace ℝ (Fin n)) :
    0 < coherentOverlap q k :=
  Real.exp_pos _

theorem coherentOverlap_ne_zero (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k ≠ 0 :=
  ne_of_gt (coherentOverlap_pos q k)

/-- The overlap never exceeds `1` (Cauchy–Schwarz for coherent states). -/
theorem coherentOverlap_le_one (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k ≤ 1 := by
  rw [coherentOverlap_eq_gaussian, Real.exp_le_one_iff]
  have : (0 : ℝ) ≤ ‖q - k‖ ^ 2 := sq_nonneg _
  linarith

/-- The kernel is symmetric. -/
theorem coherentOverlap_comm (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = coherentOverlap k q := by
  rw [coherentOverlap, coherentOverlap, real_inner_comm]
  ring_nf

/-- **A coherent state is normalized:** `⟨q|q⟩ = 1` for every parameter `q`. -/
theorem coherentOverlap_self (q : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q q = 1 := by
  rw [coherentOverlap_eq_gaussian]
  simp

/-- In particular the overlap of a *unit* coherent-state parameter with itself is
`1`. -/
theorem coherentOverlap_unit (q : EuclideanSpace ℝ (Fin n)) (_hq : ‖q‖ = 1) :
    coherentOverlap q q = 1 :=
  coherentOverlap_self q

/-- The overlap saturates its bound exactly on the diagonal: two coherent states
are indistinguishable iff their parameters agree. -/
theorem coherentOverlap_eq_one_iff (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = 1 ↔ q = k := by
  rw [coherentOverlap_eq_gaussian, Real.exp_eq_one_iff]
  constructor
  · intro h
    have hnorm : ‖q - k‖ ^ 2 = 0 := by linarith
    have : ‖q - k‖ = 0 := by
      have := pow_eq_zero_iff (n := 2) (by norm_num) |>.1 hnorm
      exact this
    exact sub_eq_zero.1 (norm_eq_zero.1 this)
  · rintro rfl
    simp

end BookProof.ChapterCoherentOverlap

end
