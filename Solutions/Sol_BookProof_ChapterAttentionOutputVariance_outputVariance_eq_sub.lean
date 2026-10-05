-- Generated from ChapterAttentionOutputVariance.lean — solution of BookProof.ChapterAttentionOutputVariance.outputVariance_eq_sub
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Theorems.Thm_BookProof_ChapterAttentionOutputVariance_sum_dist_sq_eq
open BookProof.ChapterAttentionOutputVariance



open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) :
    outputVariance p v = (∑ j, p j * ‖v j‖ ^ 2) - ‖observableExpectation p v‖ ^ 2 := by

  have h := sum_dist_sq_eq hp v 0
  simp only [sub_zero] at h
  linarith [h]
