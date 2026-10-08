-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.newWeight_eq
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionStreaming


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionStreaming.newWeight_eq (beta sn : ℝ) (s : Fin m → ℝ) :
    newWeight beta sn s
      = Real.exp (beta * sn) / ((∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn)) := by sorry
