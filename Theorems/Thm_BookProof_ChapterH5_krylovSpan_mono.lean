-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.krylovSpan_mono
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH5.krylovSpan_mono {m n : ℕ} (hmn : m ≤ n) :
    krylovSpan H v m ≤ krylovSpan H v n := by sorry
