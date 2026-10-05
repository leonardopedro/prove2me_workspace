-- Generated from ChapterAttentionOutput.lean — solution of BookProof.ChapterAttentionOutput.headOutput_eq_sum
import Mathlib
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterAttentionOutput



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    headOutput beta s v = ∑ j, scoreSoftmax beta s j • v j := rfl
