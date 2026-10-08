-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.norm_rankOneProj_le
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterH5.norm_rankOneProj_le (u : E) : ‖rankOneProj u‖ ≤ ‖u‖ * ‖u‖ := by sorry
