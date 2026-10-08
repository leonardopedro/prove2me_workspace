-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.shift_pow_sub_pow_mem
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterH5.shift_pow_sub_pow_mem (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    (((H - γ • 1) ^ m) v) - ((H ^ m) v) ∈ krylovSpan H v m := by sorry
