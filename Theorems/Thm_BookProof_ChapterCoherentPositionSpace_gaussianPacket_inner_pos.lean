-- Generated from ChapterCoherentPositionSpace.lean — theorem BookProof.ChapterCoherentPositionSpace.gaussianPacket_inner_pos
import Definitions.Def_ChapterCoherentOverlap
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
open BookProof.ChapterCoherentPositionSpace


open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

theorem BookProof.ChapterCoherentPositionSpace.gaussianPacket_inner_pos (a b : ℝ) :
    0 < ∫ x : ℝ, gaussianPacket a x * gaussianPacket b x := by sorry
