-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.headOutput_eq_sum
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOutput

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionOutput.headOutput_eq_sum (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    headOutput beta s v = ∑ j, scoreSoftmax beta s j • v j := by sorry
