-- Generated from ChapterAttentionOutput.lean — solution of BookProof.ChapterAttentionOutput.norm_headOutput_le
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
theorem solution (beta : ℝ) (s : Fin m → ℝ) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (i : Fin m) : ‖headOutput beta s v‖ ≤ C :=
  observableExpectation_norm_le _ (fun j => scoreSoftmax_nonneg beta s j)
      (scoreSoftmax_sum_one beta s i) v C hv
