-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.norm_rankOneProj_le
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (u : E) : ‖rankOneProj u‖ ≤ ‖u‖ * ‖u‖ := by

  rw [rankOneProj, ContinuousLinearMap.norm_smulRight_apply, innerSL_apply_norm]
