-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.seqSpan_mono
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterSirkMultiShift.seqSpan_mono (u : ℕ → E) {m n : ℕ} (hmn : m ≤ n) :
    seqSpan (K := K) u m ≤ seqSpan (K := K) u n := by sorry
