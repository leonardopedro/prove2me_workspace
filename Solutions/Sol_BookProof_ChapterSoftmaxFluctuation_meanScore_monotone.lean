-- Generated from ChapterSoftmaxFluctuation.lean — solution of BookProof.ChapterSoftmaxFluctuation.meanScore_monotone
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_meanScore
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_deriv_meanScore
open BookProof.ChapterSoftmaxFluctuation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) :
    Monotone fun b : ℝ => meanScore b s := by

  have hdiff : Differentiable ℝ fun b : ℝ => meanScore b s := fun b =>
    (hasDerivAt_meanScore b s i).differentiableAt
  refine monotone_of_deriv_nonneg hdiff fun b => ?_
  rw [deriv_meanScore b s i]
  exact varScore_nonneg b s
