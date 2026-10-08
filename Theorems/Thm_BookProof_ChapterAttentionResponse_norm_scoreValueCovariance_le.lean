-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.norm_scoreValueCovariance_le
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionResponse.norm_scoreValueCovariance_le (beta : ℝ) {s : Fin m → ℝ} {v : Fin m → E} {C D : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (hs : ∀ j, |s j - meanScore beta s| ≤ D) (i : Fin m) :
    ‖scoreValueCovariance beta s v‖ ≤ C * D := by sorry
