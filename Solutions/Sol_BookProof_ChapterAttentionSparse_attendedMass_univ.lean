-- Generated from ChapterAttentionSparse.lean — solution of BookProof.ChapterAttentionSparse.attendedMass_univ
import Mathlib
import Definitions.Def_ChapterAttentionSparse
open BookProof.ChapterAttentionSparse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attendedMass beta s Finset.univ = 1 := scoreSoftmax_sum_one beta s i
