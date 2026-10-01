-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.krylovSpan_map_le
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH5.krylovSpan_map_le (m : ℕ) :
    Submodule.map H (krylovSpan H v m) ≤ krylovSpan H v (m + 1) := by sorry
