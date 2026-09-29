-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.krylov_multiShift_span_eq_of_shifts
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Theorems.Thm_BookProof_ChapterSirkMultiShift_krylov_multiShift_eq_standard
import Definitions.Def_ChapterH5
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (z z' : ℕ → K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z v i}
      = Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z' v i} := by

  rw [krylov_multiShift_eq_standard, krylov_multiShift_eq_standard]
