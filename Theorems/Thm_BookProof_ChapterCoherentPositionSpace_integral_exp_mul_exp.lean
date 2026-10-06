-- Generated from ChapterCoherentPositionSpace.lean — theorem BookProof.ChapterCoherentPositionSpace.integral_exp_mul_exp
import Definitions.Def_ChapterCoherentOverlap
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
open BookProof.ChapterCoherentPositionSpace


open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

theorem BookProof.ChapterCoherentPositionSpace.integral_exp_mul_exp (a b : ℝ) :
    (∫ x : ℝ, Real.exp (-(x - a) ^ 2 / 2) * Real.exp (-(x - b) ^ 2 / 2))
      = Real.exp (-(a - b) ^ 2 / 4) * Real.sqrt Real.pi := by sorry
