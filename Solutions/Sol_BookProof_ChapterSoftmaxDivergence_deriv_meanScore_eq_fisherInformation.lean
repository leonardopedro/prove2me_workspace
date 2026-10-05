-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.deriv_meanScore_eq_fisherInformation
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_deriv_meanScore
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun b : ℝ => meanScore b s) beta = fisherInformation beta s := deriv_meanScore beta s i
