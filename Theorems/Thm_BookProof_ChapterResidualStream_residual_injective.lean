-- Generated from ChapterResidualStream.lean — theorem BookProof.ChapterResidualStream.residual_injective
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterResidualStream
import Definitions.Def_ChapterA4
open BookProof.ChapterResidualStream

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput


theorem BookProof.ChapterResidualStream.residual_injective {f : E → E} {L : ℝ} (hL : L < 1)
    (hf : ∀ x y, ‖f x - f y‖ ≤ L * ‖x - y‖) :
    Function.Injective (residual f) := by sorry
