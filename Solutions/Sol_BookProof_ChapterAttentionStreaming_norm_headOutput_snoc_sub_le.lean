-- Generated from ChapterAttentionStreaming.lean — solution of BookProof.ChapterAttentionStreaming.norm_headOutput_snoc_sub_le
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Theorems.Thm_BookProof_ChapterAttentionStreaming_newWeight_pos
import Theorems.Thm_BookProof_ChapterAttentionStreaming_headOutput_snoc
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterAttentionOutput
open BookProof.ChapterAttentionStreaming



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta sn : ℝ) (s : Fin m → ℝ) (vn : E) (v : Fin m → E) :
    ‖headOutput beta (Fin.snoc s sn) (Fin.snoc v vn) - headOutput beta s v‖
      = newWeight beta sn s * ‖vn - headOutput beta s v‖ := by

  have hdiff : headOutput beta (Fin.snoc s sn) (Fin.snoc v vn) - headOutput beta s v
      = newWeight beta sn s • (vn - headOutput beta s v) := by
    rw [headOutput_snoc, smul_sub, sub_smul, one_smul]
    abel
  rw [hdiff, norm_smul, Real.norm_eq_abs, abs_of_pos (newWeight_pos beta sn s)]
