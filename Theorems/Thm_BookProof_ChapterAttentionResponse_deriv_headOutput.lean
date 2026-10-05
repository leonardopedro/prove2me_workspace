-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.deriv_headOutput
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionResponse
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionResponse.deriv_headOutput (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    deriv (fun b : ℝ => headOutput b s v) beta = scoreValueCovariance beta s v := by sorry
