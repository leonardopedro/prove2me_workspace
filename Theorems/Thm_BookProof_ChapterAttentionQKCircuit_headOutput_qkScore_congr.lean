-- Generated from ChapterAttentionQKCircuit.lean — theorem BookProof.ChapterAttentionQKCircuit.headOutput_qkScore_congr
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionQKCircuit
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterAttentionQKCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionOutput

variable {d n m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionQKCircuit.headOutput_qkScore_congr (beta : ℝ) {WQ₁ WK₁ WQ₂ WK₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : qkMatrix WQ₁ WK₁ = qkMatrix WQ₂ WK₂) (x : Fin n → ℝ) (k : Fin m → Fin n → ℝ)
    (v : Fin m → E) :
    headOutput beta (fun l => qkScore WQ₁ WK₁ x (k l)) v
      = headOutput beta (fun l => qkScore WQ₂ WK₂ x (k l)) v := by sorry
