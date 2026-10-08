-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.norm_headOutput_le
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOutput


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionOutput.norm_headOutput_le (beta : ℝ) (s : Fin m → ℝ) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (i : Fin m) : ‖headOutput beta s v‖ ≤ C := by sorry
