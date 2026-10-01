-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.pow_mem_seqSpan
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Definitions.Def_ChapterH5
open BookProof.ChapterH5
open BookProof.ChapterSirkMultiShift

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}


noncomputable section


open BookProof.ChapterH5


theorem BookProof.ChapterSirkMultiShift.pow_mem_seqSpan (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (i : ℕ) :
    (H ^ i) v ∈ seqSpan (K := K) u (i + 1) := by sorry
