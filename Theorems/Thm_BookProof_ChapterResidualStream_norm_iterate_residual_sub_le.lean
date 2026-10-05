-- Generated from ChapterResidualStream.lean — theorem BookProof.ChapterResidualStream.norm_iterate_residual_sub_le
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
import Mathlib
import Definitions.Def_ChapterResidualStream
open BookProof.ChapterResidualStream

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput


theorem BookProof.ChapterResidualStream.norm_iterate_residual_sub_le {f : E → E} {C : ℝ} (hf : ∀ x, ‖f x‖ ≤ C) (n : ℕ)
    (x : E) :
    ‖(residual f)^[n] x - x‖ ≤ n * C := by sorry
