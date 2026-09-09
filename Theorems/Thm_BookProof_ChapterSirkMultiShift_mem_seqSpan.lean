-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.mem_seqSpan
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterSirkMultiShift.mem_seqSpan (u : ℕ → E) {i m : ℕ} (hi : i < m) :
    u i ∈ seqSpan (K := K) u m := by sorry
