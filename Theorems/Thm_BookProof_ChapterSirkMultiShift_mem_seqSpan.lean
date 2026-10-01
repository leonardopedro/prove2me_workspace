-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.mem_seqSpan
import Definitions.Def_ChapterH5
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]


noncomputable section


open BookProof.ChapterH5


theorem BookProof.ChapterSirkMultiShift.mem_seqSpan (u : ℕ → E) {i m : ℕ} (hi : i < m) :
    u i ∈ seqSpan (K := K) u m := by sorry
