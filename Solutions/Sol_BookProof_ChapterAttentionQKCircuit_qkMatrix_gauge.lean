-- Generated from ChapterAttentionQKCircuit.lean — solution of BookProof.ChapterAttentionQKCircuit.qkMatrix_gauge
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
open BookProof.ChapterAttentionQKCircuit



open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {A B : Matrix (Fin d) (Fin d) ℝ} (hAB : Aᵀ * B = 1)
    (WQ WK : Matrix (Fin d) (Fin n) ℝ) :
    qkMatrix (A * WQ) (B * WK) = qkMatrix WQ WK := by

  rw [qkMatrix, qkMatrix, Matrix.transpose_mul]
  calc WQᵀ * Aᵀ * (B * WK) = WQᵀ * (Aᵀ * B) * WK := by
        simp [Matrix.mul_assoc]
    _ = WQᵀ * WK := by rw [hAB, Matrix.mul_one]
