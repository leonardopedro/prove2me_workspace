-- Generated from ChapterH5.lean — solution of BookProof.ChapterH5.noInversionSeq_eq
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5



noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (γ : K) (v : E) (k : ℕ) :
    noInversionSeq H γ v k = (((H - γ • 1) ^ k) v) := by

  induction k with
  | zero => simp [noInversionSeq]
  | succ k ih =>
    rw [noInversionSeq, ih, pow_succ']
    rfl
