-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.effectiveSupport_uniform
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCollision.effectiveSupport_uniform (hm : 0 < m) :
    effectiveSupport (fun _ : Fin m => (1 : ℝ) / m) = (m : ℝ) := by sorry
