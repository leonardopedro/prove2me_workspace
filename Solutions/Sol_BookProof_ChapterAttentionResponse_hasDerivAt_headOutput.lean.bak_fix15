-- Generated from ChapterAttentionResponse.lean — solution of BookProof.ChapterAttentionResponse.hasDerivAt_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Theorems.Thm_BookProof_ChapterAttentionOutput_headOutput_eq_sum
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_scoreSoftmax
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterSoftmaxFluctuation
open BookProof.ChapterAttentionOutput
open BookProof.ChapterAttentionResponse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    HasDerivAt (fun b : ℝ => headOutput b s v) (scoreValueCovariance beta s v) beta := by

  have h := HasDerivAt.sum (u := (Finset.univ : Finset (Fin m)))
    (A := fun (j : Fin m) (b : ℝ) => scoreSoftmax b s j • v j)
    (A' := fun j => (scoreSoftmax beta s j * (s j - meanScore beta s)) • v j)
    (fun j _ => (hasDerivAt_scoreSoftmax beta s j).smul_const (v j))
  have key : (∑ j : Fin m, fun b : ℝ => scoreSoftmax b s j • v j)
      = fun b : ℝ => headOutput b s v := by
    funext b
    rw [Finset.sum_apply, headOutput_eq_sum]
  rw [key] at h
  exact h
