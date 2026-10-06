-- Generated from ChapterCoherentPositionSpace.lean — solution of BookProof.ChapterCoherentPositionSpace.integral_exp_neg_sq_sub
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
open BookProof.ChapterCoherentPositionSpace



open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) :
    (∫ x : ℝ, Real.exp (-(x - c) ^ 2)) = Real.sqrt Real.pi := by

  have h := MeasureTheory.integral_sub_right_eq_self (μ := (volume : Measure ℝ))
      (fun x : ℝ => Real.exp (-x ^ 2)) c
  rw [h]
  simpa using integral_gaussian 1
