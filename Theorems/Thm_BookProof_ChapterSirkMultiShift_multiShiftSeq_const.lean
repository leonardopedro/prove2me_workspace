-- Generated from ChapterSirkMultiShift.lean — theorem BookProof.ChapterSirkMultiShift.multiShiftSeq_const
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
open BookProof.ChapterSirkMultiShift










noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterSirkMultiShift.multiShiftSeq_const (H : E →ₗ[K] E) (γ : K) (v : E) (k : ℕ) :
    multiShiftSeq H (fun _ => γ) v k = noInversionSeq H γ v k := by sorry
