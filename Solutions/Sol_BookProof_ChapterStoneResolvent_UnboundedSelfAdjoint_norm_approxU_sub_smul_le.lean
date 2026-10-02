-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_smul_le
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_zero_param
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_approxU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_sub_apply_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_zero
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n h : ℝ) (x : H) :
    ‖T.approxU n h x - x - h • T.yosidaGen n x‖
      ≤ (|h| * ‖T.yosida n (T.yosidaGen n x)‖) * |h| := by

  set v : H := T.yosidaGen n x with hv
  set M : ℝ := ‖T.yosida n v‖ with hM
  set g : ℝ → H := fun s => T.approxU n s x - x - s • v with hg
  have hderiv : ∀ s : ℝ, HasDerivAt g (T.approxU n s v - v) s := by
    intro s
    have h1 : HasDerivAt (fun s : ℝ => T.approxU n s x) ((T.approxU n s * T.yosidaGen n) x) s :=
      T.hasDerivAt_approxU_apply n s x
    have h2 : HasDerivAt (fun s : ℝ => s • v) v s := by
      simpa using (hasDerivAt_id s).smul_const v
    have h0 := (h1.sub_const x).sub h2
    have hvrw : T.approxU n s v - v = T.approxU n s (T.yosidaGen n x) - v := by simp [hv]
    rw [hvrw]
    simp only [hg]
    exact h0
  have hbound : ∀ s ∈ Set.uIcc (0 : ℝ) h, ‖T.approxU n s v - v‖ ≤ |h| * M := by
    intro s hs
    have hsh : |s| ≤ |h| := by
      rcases Set.mem_uIcc.mp hs with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · rw [abs_of_nonneg h1, abs_of_nonneg (h1.trans h2)]
        exact h2
      · rw [abs_of_nonpos h2, abs_of_nonpos (h1.trans h2)]
        linarith
    have h0 : ‖T.approxU n s v - v‖ ≤ |s| * ‖T.yosida n v‖ := by
      have := T.norm_approxU_sub_apply_le n 0 s v
      simpa using this
    calc ‖T.approxU n s v - v‖ ≤ |s| * M := h0
      _ ≤ |h| * M := by
          exact mul_le_mul_of_nonneg_right hsh (norm_nonneg _)
  have hmvt : ‖g h - g 0‖ ≤ (|h| * M) * ‖h - 0‖ :=
    Convex.norm_image_sub_le_of_norm_hasDerivWithin_le
      (fun s _ => (hderiv s).hasDerivWithinAt) hbound (convex_uIcc 0 h)
      (Set.left_mem_uIc
