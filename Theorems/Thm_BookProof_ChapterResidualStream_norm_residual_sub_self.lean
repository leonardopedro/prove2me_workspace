-- Generated from ChapterResidualStream.lean — theorem BookProof.ChapterResidualStream.norm_residual_sub_self
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
import Mathlib
import Definitions.Def_ChapterResidualStream
open BookProof.ChapterResidualStream

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput


theorem BookProof.ChapterResidualStream.norm_residual_sub_self (f : E → E) (x : E) : ‖residual f x - x‖ = ‖f x‖ := by sorry
