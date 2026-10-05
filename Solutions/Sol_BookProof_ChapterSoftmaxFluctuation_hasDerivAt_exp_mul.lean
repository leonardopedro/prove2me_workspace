-- Generated from ChapterSoftmaxFluctuation.lean — solution of BookProof.ChapterSoftmaxFluctuation.hasDerivAt_exp_mul
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterSoftmaxFluctuation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta c : ℝ) :
    HasDerivAt (fun b : ℝ => Real.exp (b * c)) (c * Real.exp (beta * c)) beta := by

  have h : HasDerivAt (fun b : ℝ => b * c) c beta := by
    simpa using (hasDerivAt_id beta).mul_const c
  simpa [mul_comm] using h.exp
