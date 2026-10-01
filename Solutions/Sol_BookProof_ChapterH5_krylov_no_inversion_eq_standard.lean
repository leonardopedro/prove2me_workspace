-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.krylov_no_inversion_eq_standard
import Mathlib
import Definitions.Def_ChapterH5
import Theorems.Thm_BookProof_ChapterH5_krylovSpan_shift_eq
import Theorems.Thm_BookProof_ChapterH5_noInversionSeq_eq
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = noInversionSeq H γ v i} = krylovSpan H v m := by

  have hset : {x : E | ∃ i < m, x = noInversionSeq H γ v i}
      = {x : E | ∃ i < m, x = (((H - γ • 1) ^ i) v)} := by
    ext x
    constructor
    · rintro ⟨i, hi, rfl⟩; exact ⟨i, hi, noInversionSeq_eq H γ v i⟩
    · rintro ⟨i, hi, rfl⟩; exact ⟨i, hi, (noInversionSeq_eq H γ v i).symm⟩
  rw [hset]
  exact krylovSpan_shift_eq H γ v m
