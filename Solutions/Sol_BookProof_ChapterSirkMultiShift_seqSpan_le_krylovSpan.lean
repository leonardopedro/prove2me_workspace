-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.seqSpan_le_krylovSpan
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (m : ℕ) :
    seqSpan (K := K) u m ≤ krylovSpan H v m := by

  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  have hsplit : u i = (u i - (H ^ i) v) + (H ^ i) v := by abel
  rw [hsplit]
  exact Submodule.add_mem _
    (krylovSpan_mono (le_of_lt hi) (hu i))
    (pow_apply_mem_krylovSpan hi)
