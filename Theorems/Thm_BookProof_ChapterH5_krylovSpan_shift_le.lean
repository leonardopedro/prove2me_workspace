-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.krylovSpan_shift_le
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}


noncomputable section




theorem BookProof.ChapterH5.krylovSpan_shift_le (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    krylovSpan (H - γ • 1) v m ≤ krylovSpan H v m := by sorry
