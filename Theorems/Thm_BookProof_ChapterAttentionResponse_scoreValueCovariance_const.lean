-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.scoreValueCovariance_const
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionResponse.scoreValueCovariance_const (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    scoreValueCovariance beta s (fun _ => w) = (0 : E) := by sorry
