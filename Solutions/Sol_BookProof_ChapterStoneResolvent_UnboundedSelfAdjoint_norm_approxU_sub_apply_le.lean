-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_apply_le
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_hasDerivAt_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_commute_gen
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_approxU
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n m t : ℝ) (x : H) :
    ‖T.approxU n t x - T.approxU m t x‖ ≤ |t| * ‖T.yosida n x - T.yosida m x‖ := by

  set C : ℝ := ‖T.yosida n x - T.yosida m x‖ with hC
  set P : ℝ → (H →L[ℂ] H) := fun s => T.approxU n (t - s) * T.approxU m s with hP
  set D : ℝ → (H →L[ℂ] H) :=
    fun s => (T.approxU n (t - s) * T.approxU m s) * (T.yosidaGen m - T.yosidaGen n) with hD
  have hderiv : ∀ s : ℝ, HasDerivAt (fun s => P s x) (D s x) s := by
    intro s
    have hc : HasDerivAt (fun s : ℝ => T.approxU n (t - s))
        (-(T.approxU n (t - s) * T.yosidaGen n)) s := by
      have h1 := T.hasDerivAt_approxU n (t - s)
      have h2 : HasDerivAt (fun s : ℝ => t - s) (-1 : ℝ) s := by
        simpa using (hasDerivAt_id s).const_sub t
      have h0 := h1.scomp s h2
      simp only [neg_smul, one_smul] at h0
      convert h0 using 1 <;> rfl
    have hd : HasDerivAt (fun s : ℝ => T.approxU m s) (T.approxU m s * T.yosidaGen m) s :=
      T.hasDerivAt_approxU m s
    have hmul := hc.mul hd
    have hcomm : T.yosidaGen n * T.approxU m s = T.approxU m s * T.yosidaGen n :=
      (T.approxU_commute_gen n m s).eq
    have hEq : -(T.approxU n (t - s) * T.yosidaGen n) * T.approxU m s
        + T.approxU n (t - s) * (T.approxU m s * T.yosidaGen m) = D s := by
      calc -(T.approxU n (t - s) * T.yosidaGen n) * T.approxU m s
            + T.approxU n (t - s) * (T.approxU m s * T.yosidaGen m)
          = -(T.approxU n (t - s) * (T.yosidaGen n * T.approxU m s))
            + T.approxU n (t - s) * (T.approxU m s * T.yosidaGen m) := by noncomm_ring
        _ = -(T.approxU n (t - s) * (T.approxU m s * T.yosidaGen n))
            + T.approxU n (t - s) * (T.approxU m s * T.yosidaGen m) := by rw [hcomm]
        _ = D s := by rw [hD]; noncomm_ring
    rw [hP]
    exact hasDerivAt_apply x (hEq ▸ hmul)
  have hnorm : ∀ s : ℝ, ‖D s x‖ = C := by
    intro s
    have h1 : D s x = T.approxU n (t - s) (T.approxU m s ((T.yosidaGen m - T.yosidaGen n) x)) :=
      rfl
    rw [h1, T.norm_approxU_apply, T.norm_approxU_apply]
    have h2 : (T.yosidaGen m - T.yosidaGen n) x = (-Complex.I) • (T.yosida m x - T.yosida n x) := by
      simp [yosidaGen, smul_sub]
    rw [h2, norm_smul, hC]
    simp [norm_sub_rev]
  have hmvt : ‖P t x - P 0 x‖ ≤ C * ‖t - 0‖ := by
    refine Convex.norm_image_sub_le_of_norm_hasDerivWithin_le
      (f := fun s => P s x) (f' := fun s => D s x) (C := C) (s := Set.univ)
      (fun s _ => (hderiv s).hasDerivWithinAt) (fun s _ => le_of_eq (hnorm s)) convex_univ
      (Set.mem_univ 0) (Set.mem_univ t)
  have hPt : P t x = T.approxU m t x := by
    simp [hP]
  have hP0 : P 0 x = T.approxU n t x := by
    simp [hP]
  rw [hPt, hP0] at hmvt
  calc ‖T.approxU n t x - T.approxU m t x‖
      = ‖T.approxU m t x - T.approxU n t x‖ := norm_sub_rev _ _
    _ ≤ C * ‖t
