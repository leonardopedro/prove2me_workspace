-- Generated from ChapterCoherentPositionSpace.lean — solution of BookProof.ChapterCoherentPositionSpace.packetNorm_sq
import Mathlib
import Definitions.Def_ChapterCoherentPositionSpace
import Theorems.Thm_BookProof_ChapterCoherentPositionSpace_sqrt_pi_pos
open BookProof.ChapterCoherentPositionSpace



open scoped BigOperators
open MeasureTheory

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxSharpness

set_option maxHeartbeats 1000000 in
theorem solution : packetNorm ^ 2 = (Real.sqrt Real.pi)⁻¹ := by

  rw [packetNorm, inv_pow, Real.sq_sqrt sqrt_pi_pos.le]
