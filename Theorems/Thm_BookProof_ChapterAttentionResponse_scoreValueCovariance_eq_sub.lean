-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.scoreValueCovariance_eq_sub
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxFluctuation
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxFluctuation
open BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionResponse.scoreValueCovariance_eq_sub (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    scoreValueCovariance beta s v
      = (∑ j, (scoreSoftmax beta s j * s j) • v j) - meanScore beta s • headOutput beta s v := by sorry
