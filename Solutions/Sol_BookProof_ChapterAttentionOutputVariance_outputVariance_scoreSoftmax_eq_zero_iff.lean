-- Generated from ChapterAttentionOutputVariance.lean — solution of BookProof.ChapterAttentionOutputVariance.outputVariance_scoreSoftmax_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Theorems.Thm_BookProof_ChapterAttentionOutputVariance_outputVariance_eq_zero_iff_of_pos
open BookProof.ChapterAttentionOutputVariance



open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    outputVariance (scoreSoftmax beta s) v = 0 ↔ ∀ j, v j = headOutput beta s v := outputVariance_eq_zero_iff_of_pos (fun j => scoreSoftmax_pos beta s j) v
