-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.krylovSpan_shift_le
import Mathlib
import Definitions.Def_ChapterH5
import Theorems.Thm_BookProof_ChapterH5_pow_apply_mem_krylovSpan
import Theorems.Thm_BookProof_ChapterH5_krylovSpan_mono
import Theorems.Thm_BookProof_ChapterH5_shift_pow_sub_pow_mem
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    krylovSpan (H - γ • 1) v m ≤ krylovSpan H v m := by

  rw [krylovSpan]
  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  have hsplit : (((H - γ • 1) ^ i) v)
      = ((((H - γ • 1) ^ i) v) - ((H ^ i) v)) + ((H ^ i) v) := by abel
  rw [hsplit]
  exact Submodule.add_mem _
    (krylovSpan_mono (le_of_lt hi) (shift_pow_sub_pow_mem H γ v i))
    (pow_apply_mem_krylovSpan hi)
