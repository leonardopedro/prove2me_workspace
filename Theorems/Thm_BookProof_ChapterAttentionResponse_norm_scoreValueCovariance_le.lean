-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.norm_scoreValueCovariance_le
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionResponse.norm_scoreValueCovariance_le (beta : ℝ) {s : Fin m → ℝ} {v : Fin m → E} {C D : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (hs : ∀ j, |s j - meanScore beta s| ≤ D) (i : Fin m) :
    ‖scoreValueCovariance beta s v‖ ≤ C * D := by sorry
