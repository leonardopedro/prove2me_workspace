-- Generated from ChapterAttentionQKCircuit.lean — theorem BookProof.ChapterAttentionQKCircuit.qkScore_congr_of_qkMatrix_eq
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
open BookProof.ChapterAttentionQKCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionQKCircuit.qkScore_congr_of_qkMatrix_eq {WQ₁ WK₁ WQ₂ WK₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : qkMatrix WQ₁ WK₁ = qkMatrix WQ₂ WK₂) (x y : Fin n → ℝ) :
    qkScore WQ₁ WK₁ x y = qkScore WQ₂ WK₂ x y := by sorry
