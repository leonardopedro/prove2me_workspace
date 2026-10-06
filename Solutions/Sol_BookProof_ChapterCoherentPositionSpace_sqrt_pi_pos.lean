-- Generated from ChapterCoherentPositionSpace.lean — solution of BookProof.ChapterCoherentPositionSpace.sqrt_pi_pos
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
open BookProof.ChapterCoherentPositionSpace



open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

set_option maxHeartbeats 1000000 in
theorem solution : 0 < Real.sqrt Real.pi := Real.sqrt_pos.2 Real.pi_pos
