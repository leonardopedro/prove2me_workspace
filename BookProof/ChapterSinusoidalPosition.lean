import Mathlib
import BookProof.ChapterAttentionRetrieval

/-!
# Chapter "The Coherent State of Attention": sinusoidal positions

`ChapterRotaryPosition` proves that the rotary encoding makes the alignment a
function of the *offset* of two positions.  The original sinusoidal encoding of a
transformer — a bank of sines and cosines at fixed frequencies — has the same
property, and this module proves it directly.

* `peInner_eq_sum_cos` — the alignment of two encoded positions is
  `∑ₐ cos(ωₐ(p − q))`: **it depends on the two positions only through their
  difference** (`peInner_shift`), so a head reading sinusoidally encoded positions
  is automatically translation-equivariant.
* `peInner_self`, `abs_peInner_le` — every encoded position has the same squared
  length `n`, and the alignment is bounded by `n`.
* `scoreSoftmax_sinusoidal_shift` — hence every attention weight is unchanged by a
  global shift of all positions, and `scoreSoftmax_sinusoidal_ge` gives the
  finite-temperature floor `e^{−2βn}/m` for the weight of every key.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSinusoidalPosition

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionRetrieval

variable {n : ℕ}

/-- The **sinusoidal positional encoding** at frequencies `w`: the position `p` is
sent to the bank of pairs `(sin(ωₐp), cos(ωₐp))`. -/
def sinusoidalEncode (w : Fin n → ℝ) (p : ℝ) (a : Fin n) : ℝ × ℝ :=
  (Real.sin (w a * p), Real.cos (w a * p))

/-- The alignment (inner product) of two encoded positions. -/
def peInner (w : Fin n → ℝ) (p q : ℝ) : ℝ :=
  ∑ a, ((sinusoidalEncode w p a).1 * (sinusoidalEncode w q a).1
    + (sinusoidalEncode w p a).2 * (sinusoidalEncode w q a).2)

/-- **The alignment depends only on the offset.** -/
theorem peInner_eq_sum_cos (w : Fin n → ℝ) (p q : ℝ) :
    peInner w p q = ∑ a, Real.cos (w a * (p - q)) := by
  refine Finset.sum_congr rfl fun a _ => ?_
  have h : w a * (p - q) = w a * p - w a * q := by ring
  rw [h, Real.cos_sub]
  simp only [sinusoidalEncode]
  ring

/-- A global shift of all positions leaves every alignment unchanged. -/
theorem peInner_shift (w : Fin n → ℝ) (p q t : ℝ) :
    peInner w (p + t) (q + t) = peInner w p q := by
  rw [peInner_eq_sum_cos, peInner_eq_sum_cos]
  exact Finset.sum_congr rfl fun a _ => by ring_nf

theorem peInner_symm (w : Fin n → ℝ) (p q : ℝ) : peInner w p q = peInner w q p := by
  rw [peInner_eq_sum_cos, peInner_eq_sum_cos]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [show w a * (q - p) = -(w a * (p - q)) by ring, Real.cos_neg]

/-- Every encoded position has the same squared length `n`. -/
theorem peInner_self (w : Fin n → ℝ) (p : ℝ) : peInner w p p = (n : ℝ) := by
  rw [peInner_eq_sum_cos]
  simp

theorem abs_peInner_le (w : Fin n → ℝ) (p q : ℝ) : |peInner w p q| ≤ (n : ℝ) := by
  rw [peInner_eq_sum_cos]
  calc |∑ a, Real.cos (w a * (p - q))| ≤ ∑ a, |Real.cos (w a * (p - q))| :=
        Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _a : Fin n, (1 : ℝ) := Finset.sum_le_sum fun a _ => Real.abs_cos_le_one _
    _ = (n : ℝ) := by simp

/-! ## Consequences for the attention weights -/

/-- **Attention over sinusoidal positions is translation-equivariant**: shifting the
query position and every key position by the same amount leaves every attention
weight unchanged. -/
theorem scoreSoftmax_sinusoidal_shift {m : ℕ} (beta : ℝ) (w : Fin n → ℝ) (p t : ℝ)
    (k : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => peInner w (p + t) (k l + t)) j
      = scoreSoftmax beta (fun l => peInner w p (k l)) j := by
  congr 1
  funext l
  exact peInner_shift w p (k l) t

/-- With sinusoidal positions the scores span at most `2n`, so at `β ≥ 0` no key
ever drops below `e^{−2βn}/m` of the attention. -/
theorem scoreSoftmax_sinusoidal_ge {m : ℕ} {beta : ℝ} (hb : 0 ≤ beta) (w : Fin n → ℝ)
    (p : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    Real.exp (-(beta * (2 * n))) / (m : ℝ)
      ≤ scoreSoftmax beta (fun l => peInner w p (k l)) j := by
  refine scoreSoftmax_ge_of_spread hb _ j fun l => ?_
  have h1 := abs_le.mp (abs_peInner_le w p (k l))
  have h2 := abs_le.mp (abs_peInner_le w p (k j))
  linarith [h1.2, h2.1]

end BookProof.ChapterSinusoidalPosition

end
