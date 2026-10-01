-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.seqSpan_mono
import Definitions.Def_ChapterH5
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]


noncomputable section


open BookProof.ChapterH5


theorem BookProof.ChapterSirkMultiShift.seqSpan_mono (u : ℕ → E) {m n : ℕ} (hmn : m ≤ n) :
    seqSpan (K := K) u m ≤ seqSpan (K := K) u n := by sorry
