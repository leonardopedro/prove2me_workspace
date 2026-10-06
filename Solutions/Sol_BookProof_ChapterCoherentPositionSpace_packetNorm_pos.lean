-- Generated from ChapterCoherentPositionSpace.lean — solution of BookProof.ChapterCoherentPositionSpace.packetNorm_pos
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
import Theorems.Thm_BookProof_ChapterCoherentPositionSpace_sqrt_pi_pos
open BookProof.ChapterCoherentPositionSpace



open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

set_option maxHeartbeats 1000000 in
theorem solution : 0 < packetNorm := inv_pos.2 (Real.sqrt_pos.2 sqrt_pi_pos)
