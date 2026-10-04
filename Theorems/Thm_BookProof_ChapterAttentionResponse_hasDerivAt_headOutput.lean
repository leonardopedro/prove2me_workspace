-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.hasDerivAt_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionResponse.hasDerivAt_headOutput (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    HasDerivAt (fun b : ℝ => headOutput b s v) (scoreValueCovariance beta s v) beta := by sorry
