-- Generated from ChapterAttentionQKCircuit.lean — theorem BookProof.ChapterAttentionQKCircuit.qkScore_gauge
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
open BookProof.ChapterAttentionQKCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionQKCircuit.qkScore_gauge {A B : Matrix (Fin d) (Fin d) ℝ} (hAB : Aᵀ * B = 1)
    (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x y : Fin n → ℝ) :
    qkScore (A * WQ) (B * WK) x y = qkScore WQ WK x y := by sorry
