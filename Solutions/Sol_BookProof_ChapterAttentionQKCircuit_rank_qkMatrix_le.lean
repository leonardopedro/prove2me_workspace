-- Generated from ChapterAttentionQKCircuit.lean — solution of BookProof.ChapterAttentionQKCircuit.rank_qkMatrix_le
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
open BookProof.ChapterAttentionQKCircuit



open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (WQ WK : Matrix (Fin d) (Fin n) ℝ) : (qkMatrix WQ WK).rank ≤ d := le_trans (Matrix.rank_mul_le_left _ _) (by simpa using Matrix.rank_le_width (A := WQᵀ))
