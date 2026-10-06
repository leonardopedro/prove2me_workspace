-- Generated from ChapterCoherentPositionSpace.lean — solution of BookProof.ChapterCoherentPositionSpace.gaussianPacket_sq_integral
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
import Theorems.Thm_BookProof_ChapterCoherentPositionSpace_gaussianPacket_inner
open BookProof.ChapterCoherentPositionSpace



open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) :
    (∫ x : ℝ, gaussianPacket a x * gaussianPacket a x) = 1 := by

  rw [gaussianPacket_inner]; simp
