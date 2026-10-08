-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.krylovSpan_mono
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterH5.krylovSpan_mono {m n : ℕ} (hmn : m ≤ n) :
    krylovSpan H v m ≤ krylovSpan H v n := by sorry
