-- Generated from ChapterAttentionQKCircuit.lean — theorem BookProof.ChapterAttentionQKCircuit.qkScore_eq_bilinear
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
open BookProof.ChapterAttentionQKCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionQKCircuit.qkScore_eq_bilinear (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x y : Fin n → ℝ) :
    qkScore WQ WK x y = x ⬝ᵥ (qkMatrix WQ WK *ᵥ y) := by sorry
