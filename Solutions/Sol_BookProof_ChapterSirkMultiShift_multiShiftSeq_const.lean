-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.multiShiftSeq_const
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Definitions.Def_ChapterH5
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (γ : K) (v : E) (k : ℕ) :
    multiShiftSeq H (fun _ => γ) v k = noInversionSeq H γ v k := by

  induction k with
  | zero => rfl
  | succ k ih => rw [multiShiftSeq, ih]; rfl
