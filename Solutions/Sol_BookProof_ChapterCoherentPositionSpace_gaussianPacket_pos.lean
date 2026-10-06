-- Generated from ChapterCoherentPositionSpace.lean — solution of BookProof.ChapterCoherentPositionSpace.gaussianPacket_pos
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
import Theorems.Thm_BookProof_ChapterCoherentPositionSpace_packetNorm_pos
open BookProof.ChapterCoherentPositionSpace



open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

set_option maxHeartbeats 1000000 in
theorem solution (a x : ℝ) : 0 < gaussianPacket a x := mul_pos packetNorm_pos (Real.exp_pos _)
