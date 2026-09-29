-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.mem_seqSpan
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Definitions.Def_ChapterH5
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

set_option maxHeartbeats 1000000 in
theorem solution (u : ℕ → E) {i m : ℕ} (hi : i < m) :
    u i ∈ seqSpan (K := K) u m := Submodule.subset_span ⟨i, hi, rfl⟩
