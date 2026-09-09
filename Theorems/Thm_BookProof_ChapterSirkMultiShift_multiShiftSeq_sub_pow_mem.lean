-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.multiShiftSeq_sub_pow_mem
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterSirkMultiShift.multiShiftSeq_sub_pow_mem (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (k : ℕ) :
    multiShiftSeq H z v k - (H ^ k) v ∈ krylovSpan H v k := by sorry
