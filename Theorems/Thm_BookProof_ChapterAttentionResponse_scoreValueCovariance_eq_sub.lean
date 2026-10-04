-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.scoreValueCovariance_eq_sub
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionResponse.scoreValueCovariance_eq_sub (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    scoreValueCovariance beta s v
      = (∑ j, (scoreSoftmax beta s j * s j) • v j) - meanScore beta s • headOutput beta s v := by sorry
