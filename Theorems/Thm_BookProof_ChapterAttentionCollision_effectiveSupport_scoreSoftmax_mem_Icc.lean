-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.effectiveSupport_scoreSoftmax_mem_Icc
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCollision.effectiveSupport_scoreSoftmax_mem_Icc (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    effectiveSupport (scoreSoftmax beta s) ∈ Set.Icc (1 : ℝ) (m : ℝ) := by sorry
