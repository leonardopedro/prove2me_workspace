-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_stoneU_sub_taylor_le
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_sub_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {tau : ℝ} (htau : 0 ≤ tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖T.stoneU tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)‖
      ≤ tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by

  set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
  set C : ℝ := tau * ‖T.op x2‖ with hC
  set f : ℝ → H := fun s => T.stoneU s (x : H) - ((x : H) - ((s : ℂ) * Complex.I) • T.op x)
    with hf
  have hderiv : ∀ s : ℝ, HasDerivAt f
      (T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x) s := by
    intro s
    have h1 : HasDerivAt (fun s : ℝ => T.stoneU s (x : H))
        (T.stoneU s ((-Complex.I) • T.op x)) s := T.hasDerivAt_stoneU x s
    have h2 : HasDerivAt (fun s : ℝ => ((s : ℂ) * Complex.I) • T.op x)
        (Complex.I • T.op x) s := by
      have hc : HasDerivAt (fun s : ℝ => ((s : ℂ) * Complex.I)) Complex.I s := by
        simpa using (Complex.ofRealCLM.hasDerivAt (x := s)).mul_const Complex.I
      simpa using hc.smul_const (T.op x)
    have h3 : HasDerivAt (fun s : ℝ => (x : H) - ((s : ℂ) * Complex.I) • T.op x)
        (-(Complex.I • T.op x)) s := by
      have hsub := (hasDerivAt_const s (x : H)).sub h2
      convert hsub using 1
      · funext t; rfl
      · simp
    have hdh := h1.sub h3
    convert hdh using 1
    · funext t; rfl
    · simp [hf, sub_neg_eq_add]
  have hbound : ∀ s ∈ Set.Ico (0 : ℝ) tau,
      ‖T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x‖ ≤ C := by
    intro s hs
    have hsplit : T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x
        = (-Complex.I) • (T.stoneU s (T.op x) - T.op x) := by
      rw [map_smul]
      module
    rw [hsplit, norm_smul]
    have h1 : ‖T.stoneU s ((x2 : H)) - ((x2 : H))‖ ≤ |s| * ‖T.op x2‖ :=
      T.norm_stoneU_sub_domain s x2
    have hs' : |s| ≤ tau := by
      rw [abs_of_nonneg hs.1]; exact le_of_lt hs.2
    have : ‖T.stoneU s (T.op x) - T.op x‖ ≤ tau * ‖T.op x2‖ := by
      have hxx : ((x2 : H)) = T.op x := rfl
      rw [hxx] at h1
      exact le_trans h1 (mul_le_mul_of_nonneg_right hs' (norm_nonneg _))
    simpa using this
  have hzero : f 0 = 0 := by
    have h0 : T.stoneU 0 ((x : H)) = (x : H) := by
      rw [T.stoneU_zero]; simp
    have hval : f 0
        = T.stoneU 0 (x : H) - ((x : H) - (((0 : ℝ) : ℂ) * Complex.I) • T.op x) := rfl
    rw [hval, h0]
    simp
  have hmain : ‖f tau - f 0‖ ≤ C * (tau - 0) := by
    refine norm_image_sub_le_of_norm_deriv_le_segment' (f := f)
      (f' := fun s => T.stoneU s ((-Complex.I) • T.op x) + Complex.I • T.op x)
      (fun s hs => (hderiv s).hasDerivWithinAt) hbound tau (Set.right_mem_Icc.mpr htau)
  rw [hzero, sub_zero] at hmain
  calc ‖f tau‖ ≤ C * (tau - 0) := hmain
    _ = tau ^ 2 * ‖T.op x2‖ := by rw [hC]; ring
