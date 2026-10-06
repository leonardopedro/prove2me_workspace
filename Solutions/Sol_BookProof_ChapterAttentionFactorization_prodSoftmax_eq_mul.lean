-- Generated from ChapterAttentionFactorization.lean — solution of BookProof.ChapterAttentionFactorization.prodSoftmax_eq_mul
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_denom_pos
open BookProof.ChapterAttentionFactorization



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m₁ m₂ : ℕ}

variable {m₁ m₂ : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (j : Fin m₁ × Fin m₂) :
    prodSoftmax beta s₁ s₂ j = scoreSoftmax beta s₁ j.1 * scoreSoftmax beta s₂ j.2 := by

  have hZ₁ : (0 : ℝ) < ∑ a, Real.exp (beta * s₁ a) := scoreSoftmax_denom_pos beta s₁ j.1
  have hZ₂ : (0 : ℝ) < ∑ b, Real.exp (beta * s₂ b) := scoreSoftmax_denom_pos beta s₂ j.2
  have hden : ∑ l : Fin m₁ × Fin m₂, Real.exp (beta * (s₁ l.1 + s₂ l.2))
      = (∑ a, Real.exp (beta * s₁ a)) * ∑ b, Real.exp (beta * s₂ b) := by
    rw [Finset.sum_mul_sum, Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [← Real.exp_add]
    ring_nf
  rw [prodSoftmax, hden, scoreSoftmax, scoreSoftmax, div_mul_div_comm, ← Real.exp_add]
  congr 2
  ring
