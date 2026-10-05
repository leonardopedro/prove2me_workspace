-- Generated from ChapterAttentionQKCircuit.lean — solution of BookProof.ChapterAttentionQKCircuit.qkScore_eq_bilinear
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
open BookProof.ChapterAttentionQKCircuit



open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x y : Fin n → ℝ) :
    qkScore WQ WK x y = x ⬝ᵥ (qkMatrix WQ WK *ᵥ y) := by

  rw [qkScore, qkMatrix]
  conv_rhs => rw [← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec, Matrix.vecMul_transpose]
