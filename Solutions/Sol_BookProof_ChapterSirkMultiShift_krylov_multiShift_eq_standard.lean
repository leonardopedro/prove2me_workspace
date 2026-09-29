-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.krylov_multiShift_eq_standard
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Theorems.Thm_BookProof_ChapterSirkMultiShift_triangularSpan_eq_krylovSpan
import Theorems.Thm_BookProof_ChapterSirkMultiShift_multiShiftSeq_sub_pow_mem
import Definitions.Def_ChapterH5
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z v i} = krylovSpan H v m :=
  triangularSpan_eq_krylovSpan (H := H) (v := v) (multiShiftSeq H z v)
      (multiShiftSeq_sub_pow_mem H z v) m
