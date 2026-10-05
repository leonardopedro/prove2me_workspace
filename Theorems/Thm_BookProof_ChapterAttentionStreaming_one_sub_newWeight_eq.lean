-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.one_sub_newWeight_eq
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionStreaming.one_sub_newWeight_eq (beta sn : ℝ) (s : Fin m → ℝ) :
    1 - newWeight beta sn s
      = (∑ l, Real.exp (beta * s l))
          / ((∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn)) := by sorry
