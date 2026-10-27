-- Generated from ChapterBrstUnboundedLeakage.lean — solution of BookProof.BrstUnboundedLeakage.norm_flow_sub_stoneU_le
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Theorems.Thm_BookProof_BrstUnboundedLeakage_hasDerivAt_duhamel_stone
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
open BookProof.BrstUnboundedLeakage



open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {B : H →L[ℂ] H} (t : ℝ) (ht : 0 ≤ t) (x : H)
    (hdom : ∀ s : ℝ, flow B s x ∈ T.domain) (K : ℝ)
    (hK : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖T.op ⟨flow B s x, hdom s⟩ - B (flow B s x)‖ ≤ K) :
    ‖flow B t x - T.stoneU t x‖ ≤ K * t := by

  set g : ℝ → H := fun u => T.stoneU (t - u) (flow B u x) with hg
  have hderiv : ∀ s ∈ Set.Icc (0 : ℝ) t,
      HasDerivWithinAt g
        (T.stoneU (t - s) ((-Complex.I) • (B (flow B s x) - T.op ⟨flow B s x, hdom s⟩)))
        (Set.Icc 0 t) s :=
    fun s _ => (hasDerivAt_duhamel_stone T B t x hdom s).hasDerivWithinAt
  have hbound : ∀ s ∈ Set.Ico (0 : ℝ) t,
      ‖T.stoneU (t - s) ((-Complex.I) • (B (flow B s x) - T.op ⟨flow B s x, hdom s⟩))‖ ≤ K := by
    intro s hs
    have hs' : s ∈ Set.Icc (0 : ℝ) t := ⟨hs.1, hs.2.le⟩
    rw [T.norm_stoneU_apply, norm_smul]
    have hnorm : ‖B (flow B s x) - T.op ⟨flow B s x, hdom s⟩‖
        = ‖T.op ⟨flow B s x, hdom s⟩ - B (flow B s x)‖ := norm_sub_rev _ _
    simp only [norm_neg, Complex.norm_I, one_mul, hnorm]
    exact hK s hs'
  have hmvt := norm_image_sub_le_of_norm_deriv_le_segment' hderiv hbound t
    (Set.right_mem_Icc.mpr ht)
  have hgt : g t = flow B t x := by
    simp only [hg, sub_self, UnboundedSelfAdjoint.stoneU_zero, ContinuousLinearMap.one_apply]
  have hg0 : g 0 = T.stoneU t x := by
    simp only [hg, sub_zero, flow_apply_zero]
  rw [hgt, hg0] at hmvt
  simpa using hmvt
