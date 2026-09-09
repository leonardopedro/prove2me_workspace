-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.pow_mem_seqSpan
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterSirkMultiShift.pow_mem_seqSpan (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (i : ℕ) :
    (H ^ i) v ∈ seqSpan (K := K) u (i + 1) := by sorry
