-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.triangularSpan_eq_krylovSpan
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Theorems.Thm_BookProof_ChapterSirkMultiShift_seqSpan_mono
import Theorems.Thm_BookProof_ChapterSirkMultiShift_seqSpan_le_krylovSpan
import Theorems.Thm_BookProof_ChapterSirkMultiShift_pow_mem_seqSpan
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (m : ℕ) :
    seqSpan (K := K) u m = krylovSpan H v m := by

  refine le_antisymm (seqSpan_le_krylovSpan u hu m) ?_
  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  exact seqSpan_mono u (by omega) (pow_mem_seqSpan u hu i)
