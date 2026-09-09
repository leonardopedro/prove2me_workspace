-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.krylov_multiShift_eq_standard
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterSirkMultiShift.krylov_multiShift_eq_standard (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z v i} = krylovSpan H v m := by sorry
