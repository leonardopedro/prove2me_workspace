-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.headOutput_snoc
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionStreaming


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionStreaming.headOutput_snoc (beta sn : ℝ) (s : Fin m → ℝ) (vn : E) (v : Fin m → E) :
    headOutput beta (Fin.snoc s sn) (Fin.snoc v vn)
      = (1 - newWeight beta sn s) • headOutput beta s v + newWeight beta sn s • vn := by sorry
