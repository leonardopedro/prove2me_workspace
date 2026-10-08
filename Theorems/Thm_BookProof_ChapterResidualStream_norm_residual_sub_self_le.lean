-- Generated from ChapterResidualStream.lean — theorem BookProof.ChapterResidualStream.norm_residual_sub_self_le
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
import Mathlib
import Definitions.Def_ChapterResidualStream
open BookProof.ChapterResidualStream


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]


theorem BookProof.ChapterResidualStream.norm_residual_sub_self_le [NormedSpace ℝ E] (beta : ℝ) (s : Fin m → ℝ)
    {v : Fin m → E} {C : ℝ} (hv : ∀ j, ‖v j‖ ≤ C) (i : Fin m) (x : E) :
    ‖residual (fun _ => headOutput beta s v) x - x‖ ≤ C := by sorry
