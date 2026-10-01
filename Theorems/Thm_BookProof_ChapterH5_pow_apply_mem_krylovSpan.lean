-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.pow_apply_mem_krylovSpan
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH5.pow_apply_mem_krylovSpan {i m : ℕ} (hi : i < m) :
    (H ^ i) v ∈ krylovSpan H v m := by sorry
