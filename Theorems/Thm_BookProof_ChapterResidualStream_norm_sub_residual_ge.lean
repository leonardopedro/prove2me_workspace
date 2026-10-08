-- Generated from ChapterResidualStream.lean — theorem BookProof.ChapterResidualStream.norm_sub_residual_ge
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
import Mathlib
import Definitions.Def_ChapterResidualStream
open BookProof.ChapterResidualStream


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]


theorem BookProof.ChapterResidualStream.norm_sub_residual_ge {f : E → E} {L : ℝ}
    (hf : ∀ x y, ‖f x - f y‖ ≤ L * ‖x - y‖) (x y : E) :
    (1 - L) * ‖x - y‖ ≤ ‖residual f x - residual f y‖ := by sorry
