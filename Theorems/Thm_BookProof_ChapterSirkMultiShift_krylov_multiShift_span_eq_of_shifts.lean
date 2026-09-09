-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.krylov_multiShift_span_eq_of_shifts
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterSirkMultiShift.krylov_multiShift_span_eq_of_shifts (H : E →ₗ[K] E) (z z' : ℕ → K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z v i}
      = Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z' v i} := by sorry
