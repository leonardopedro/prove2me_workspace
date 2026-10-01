-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.generator_bounded_of_rankOneProjector
import Mathlib
import Definitions.Def_ChapterH5
import Theorems.Thm_BookProof_ChapterH5_norm_rankOneProj_le
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

set_option maxHeartbeats 1000000 in
theorem solution (u : E) (hu : ‖u‖ = 1) (D : E →L[ℂ] E) :
    ‖rankOneProj u + D‖ ≤ 1 + ‖D‖ := by

  refine le_trans (norm_add_le _ _) ?_
  have h := norm_rankOneProj_le u
  rw [hu] at h
  simpa using add_le_add_right (by simpa using h) ‖D‖
