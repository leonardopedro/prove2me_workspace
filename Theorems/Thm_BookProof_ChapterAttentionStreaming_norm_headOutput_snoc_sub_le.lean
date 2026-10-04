-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.norm_headOutput_snoc_sub_le
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionStreaming.norm_headOutput_snoc_sub_le (beta sn : ℝ) (s : Fin m → ℝ) (vn : E) (v : Fin m → E) :
    ‖headOutput beta (Fin.snoc s sn) (Fin.snoc v vn) - headOutput beta s v‖
      = newWeight beta sn s * ‖vn - headOutput beta s v‖ := by sorry
