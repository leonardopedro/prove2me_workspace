-- Generated from ChapterAttentionOutputVariance.lean — solution of BookProof.ChapterAttentionOutputVariance.outputVariance_scoreSoftmax_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Theorems.Thm_BookProof_ChapterAttentionOutputVariance_outputVariance_nonneg
open BookProof.ChapterAttentionOutputVariance



open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    0 ≤ outputVariance (scoreSoftmax beta s) v := outputVariance_nonneg (scoreSoftmax_nonneg beta s) v
