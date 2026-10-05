-- Generated from ChapterAttentionResponse.lean — solution of BookProof.ChapterAttentionResponse.deriv_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Theorems.Thm_BookProof_ChapterAttentionResponse_hasDerivAt_headOutput
open BookProof.ChapterAttentionResponse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    deriv (fun b : ℝ => headOutput b s v) beta = scoreValueCovariance beta s v := (hasDerivAt_headOutput beta s v).deriv
