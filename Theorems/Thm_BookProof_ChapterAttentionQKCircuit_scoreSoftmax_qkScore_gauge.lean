-- Generated from ChapterAttentionQKCircuit.lean — theorem BookProof.ChapterAttentionQKCircuit.scoreSoftmax_qkScore_gauge
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionQKCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionQKCircuit.scoreSoftmax_qkScore_gauge (beta : ℝ) {A B : Matrix (Fin d) (Fin d) ℝ}
    (hAB : Aᵀ * B = 1) (WQ WK : Matrix (Fin d) (Fin n) ℝ) (x : Fin n → ℝ)
    (k : Fin m → Fin n → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => qkScore (A * WQ) (B * WK) x (k l)) j
      = scoreSoftmax beta (fun l => qkScore WQ WK x (k l)) j := by sorry
