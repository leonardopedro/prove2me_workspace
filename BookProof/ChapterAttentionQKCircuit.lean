import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": the head only sees one matrix

A head is usually written with two learned projections, a query map `W_Q` and a key
map `W_K`, and one is tempted to read them as two separate objects — "what the
token asks" and "what the token offers".  The score, however, is
`⟪W_Q x, W_K y⟫ = xᵀ(W_Qᵀ W_K)y`: the pair enters only through the single bilinear
form `W_Qᵀ W_K`, the *QK circuit*.  This module proves that this is exactly the
gauge freedom of the head.

* `qkScore_eq_bilinear` — the score is the bilinear form of `W_Qᵀ W_K`.
* `qkScore_congr_of_qkMatrix_eq` — two parameter pairs with the same product give
  the same scores, hence (`scoreSoftmax_qkScore_congr`, `headOutput_qkScore_congr`)
  the same attention weights and the same output: the split of the circuit into two
  factors is not observable.
* `qkScore_gauge` — **the headline**: for any `A, B` with `Aᵀ B = 1` (any invertible
  `A` with `B = (Aᵀ)⁻¹`), replacing `(W_Q, W_K)` by `(A W_Q, B W_K)` changes nothing.
  The parameters of a head are defined only up to this `GL(d)` action.
* `rank_qkMatrix_le` — the circuit has rank at most the head dimension `d`, which is
  the parameter-space source of the score-table bottleneck of
  `ChapterAttentionLowRank`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionQKCircuit

open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The QK circuit -/

/-- The **QK circuit** of a head: the single matrix through which the two learned
projections act on the scores. -/
def qkMatrix (WQ WK : Matrix (Fin d) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := WQᵀ * WK

/-- The raw score of a query token `x` against a key token `y`. -/
def qkScore (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x y : Fin n → ℝ) : ℝ :=
  (WQ *ᵥ x) ⬝ᵥ (WK *ᵥ y)

/-- **The score is the bilinear form of the QK circuit.** -/
theorem qkScore_eq_bilinear (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x y : Fin n → ℝ) :
    qkScore WQ WK x y = x ⬝ᵥ (qkMatrix WQ WK *ᵥ y) := by
  rw [qkScore, qkMatrix]
  conv_rhs => rw [← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec, Matrix.vecMul_transpose]

/-- Two parameter pairs with the same circuit produce the same scores. -/
theorem qkScore_congr_of_qkMatrix_eq {WQ₁ WK₁ WQ₂ WK₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : qkMatrix WQ₁ WK₁ = qkMatrix WQ₂ WK₂) (x y : Fin n → ℝ) :
    qkScore WQ₁ WK₁ x y = qkScore WQ₂ WK₂ x y := by
  rw [qkScore_eq_bilinear, qkScore_eq_bilinear, h]

/-! ## The gauge freedom of a head -/

/-- **The `GL(d)` gauge freedom of the QK circuit.**  If `Aᵀ B = 1` then
`(A W_Q, B W_K)` has the same circuit as `(W_Q, W_K)`. -/
theorem qkMatrix_gauge {A B : Matrix (Fin d) (Fin d) ℝ} (hAB : Aᵀ * B = 1)
    (WQ WK : Matrix (Fin d) (Fin n) ℝ) :
    qkMatrix (A * WQ) (B * WK) = qkMatrix WQ WK := by
  rw [qkMatrix, qkMatrix, Matrix.transpose_mul]
  calc WQᵀ * Aᵀ * (B * WK) = WQᵀ * (Aᵀ * B) * WK := by
        simp [Matrix.mul_assoc]
    _ = WQᵀ * WK := by rw [hAB, Matrix.mul_one]

/-- The scores are gauge invariant. -/
theorem qkScore_gauge {A B : Matrix (Fin d) (Fin d) ℝ} (hAB : Aᵀ * B = 1)
    (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x y : Fin n → ℝ) :
    qkScore (A * WQ) (B * WK) x y = qkScore WQ WK x y :=
  qkScore_congr_of_qkMatrix_eq (qkMatrix_gauge hAB WQ WK) x y

/-! ## What the head does with the scores -/

/-- Attention weights depend on the parameters only through the circuit. -/
theorem scoreSoftmax_qkScore_congr (beta : ℝ) {WQ₁ WK₁ WQ₂ WK₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : qkMatrix WQ₁ WK₁ = qkMatrix WQ₂ WK₂) (x : Fin n → ℝ) (k : Fin m → Fin n → ℝ)
    (j : Fin m) :
    scoreSoftmax beta (fun l => qkScore WQ₁ WK₁ x (k l)) j
      = scoreSoftmax beta (fun l => qkScore WQ₂ WK₂ x (k l)) j := by
  have : (fun l => qkScore WQ₁ WK₁ x (k l)) = fun l => qkScore WQ₂ WK₂ x (k l) :=
    funext fun l => qkScore_congr_of_qkMatrix_eq h x (k l)
  rw [this]

/-- The head's output depends on the parameters only through the circuit. -/
theorem headOutput_qkScore_congr (beta : ℝ) {WQ₁ WK₁ WQ₂ WK₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : qkMatrix WQ₁ WK₁ = qkMatrix WQ₂ WK₂) (x : Fin n → ℝ) (k : Fin m → Fin n → ℝ)
    (v : Fin m → E) :
    headOutput beta (fun l => qkScore WQ₁ WK₁ x (k l)) v
      = headOutput beta (fun l => qkScore WQ₂ WK₂ x (k l)) v := by
  have : (fun l => qkScore WQ₁ WK₁ x (k l)) = fun l => qkScore WQ₂ WK₂ x (k l) :=
    funext fun l => qkScore_congr_of_qkMatrix_eq h x (k l)
  rw [this]

/-- The gauge action leaves every attention weight of the head untouched. -/
theorem scoreSoftmax_qkScore_gauge (beta : ℝ) {A B : Matrix (Fin d) (Fin d) ℝ}
    (hAB : Aᵀ * B = 1) (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x : Fin n → ℝ)
    (k : Fin m → Fin n → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => qkScore (A * WQ) (B * WK) x (k l)) j
      = scoreSoftmax beta (fun l => qkScore WQ WK x (k l)) j :=
  scoreSoftmax_qkScore_congr beta (qkMatrix_gauge hAB WQ WK) x k j

/-! ## The bottleneck lives in the circuit -/

/-- **The circuit is low rank.**  Whatever the width `n` of the residual stream, the
bilinear form a head can express has rank at most its head dimension `d`. -/
theorem rank_qkMatrix_le (WQ WK : Matrix (Fin d) (Fin n) ℝ) : (qkMatrix WQ WK).rank ≤ d :=
  le_trans (Matrix.rank_mul_le_left _ _) (by simpa using Matrix.rank_le_width (A := WQᵀ))

end BookProof.ChapterAttentionQKCircuit
