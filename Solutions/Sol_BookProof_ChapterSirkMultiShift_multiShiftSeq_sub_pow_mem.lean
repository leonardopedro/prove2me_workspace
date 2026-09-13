-- Generated from ChapterSirkMultiShift.lean — solution of BookProof.ChapterSirkMultiShift.multiShiftSeq_sub_pow_mem
import Mathlib
import Definitions.Def_ChapterSirkMultiShift
import Theorems.Thm_BookProof_ChapterSirkMultiShift_multiShiftSeq_succ
import Definitions.Def_ChapterH5
open BookProof.ChapterSirkMultiShift











noncomputable section


open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]





variable {H : E →ₗ[K] E} {v : E}

set_option maxHeartbeats 1000000 in
theorem solution (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (k : ℕ) :
    multiShiftSeq H z v k - (H ^ k) v ∈ krylovSpan H v k := by

  induction k with
  | zero => simp
  | succ k ih =>
    have hHstep : ((H ^ (k + 1)) v) = H ((H ^ k) v) := by rw [pow_succ']; rfl
    set d : E := multiShiftSeq H z v k - (H ^ k) v with hd
    have hdmem : d ∈ krylovSpan H v k := ih
    have hwmem : multiShiftSeq H z v k ∈ krylovSpan H v (k + 1) := by
      have : multiShiftSeq H z v k = d + (H ^ k) v := by rw [hd]; abel
      rw [this]
      exact Submodule.add_mem _
        (krylovSpan_mono (Nat.le_succ k) hdmem)
        (pow_apply_mem_krylovSpan (Nat.lt_succ_self k))
    have hHd : H d ∈ krylovSpan H v (k + 1) := krylovSpan_map_le k ⟨d, hdmem, rfl⟩
    have hrw : multiShiftSeq H z v (k + 1) - (H ^ (k + 1)) v
        = H d - z k • multiShiftSeq H z v k := by
      rw [multiShiftSeq_succ, hHstep, hd, map_sub]
      abel
    rw [hrw]
    exact Submodule.sub_mem _ hHd (Submodule.smul_mem _ _ hwmem)
