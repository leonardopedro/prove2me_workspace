-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.normSq_annA
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_normSq_toLp_of_subset
import Theorems.Thm_BookProof_FockSecondQuantization_annA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Theorems.Thm_BookProof_FockSecondQuantization_dn_up
import Theorems.Thm_BookProof_FockSecondQuantization_up_dn
import Theorems.Thm_BookProof_FockSecondQuantization_up_self
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) :
    ‖toLp (annA k u)‖ ^ 2 = ∑ α ∈ u.support, ((α k : ℝ)) * ‖u α‖ ^ 2 := by

  classical
  set T : Finset Conf := u.support.filter (fun β => 1 ≤ β k) with hT
  set f : Conf → ℝ := fun α => ((α k : ℝ) + 1) * ‖u (up k α)‖ ^ 2 with hf
  have hsupp : (annA k u).support ⊆ u.support.image (dn k) := support_annA k u
  have h1 : ‖toLp (annA k u)‖ ^ 2 = ∑ α ∈ u.support.image (dn k), f α := by
    rw [normSq_toLp_of_subset hsupp]
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [annA_apply, hf]
    simp only [norm_mul, mul_pow, Complex.norm_real, Real.norm_eq_abs]
    rw [abs_of_nonneg (Real.sqrt_nonneg _), Real.sq_sqrt (by positivity)]
  have hTsub : T.image (dn k) ⊆ u.support.image (dn k) :=
    Finset.image_subset_image (Finset.filter_subset _ _)
  have h2 : ∑ α ∈ u.support.image (dn k), f α = ∑ α ∈ T.image (dn k), f α := by
    refine (Finset.sum_subset hTsub ?_).symm
    intro α _ hα
    have hz : u (up k α) = 0 := by
      by_contra hc
      refine hα (Finset.mem_image.mpr ⟨up k α, ?_, dn_up k α⟩)
      refine Finset.mem_filter.mpr ⟨Finsupp.mem_support_iff.mpr hc, ?_⟩
      rw [up_self]; omega
    rw [hf]
    simp [hz]
  have hinj : ∀ x ∈ T, ∀ y ∈ T, dn k x = dn k y → x = y := by
    intro x hx y hy hxy
    have hx1 : 1 ≤ x k := (Finset.mem_filter.mp hx).2
    have hy1 : 1 ≤ y k := (Finset.mem_filter.mp hy).2
    rw [← up_dn k hx1, ← up_dn k hy1, hxy]
  have h3 : ∑ α ∈ T.image (dn k), f α = ∑ β ∈ T, f (dn k β) := Finset.sum_image hinj
  have h4 : ∑ β ∈ T, f (dn k β) = ∑ β ∈ T, ((β k : ℝ)) * ‖u β‖ ^ 2 := by
    refine Finset.sum_congr rfl fun β hβ => ?_
    have hb1 : 1 ≤ β k := (Finset.mem_filter.mp hβ).2
    rw [hf]
    simp only
    rw [up_dn k hb1, dn_self]
    congr 1
    rw [Nat.cast_sub hb1]
    ring
  have h5 : ∑ β ∈ T, ((β k : ℝ)) * ‖u β‖ ^ 2 = ∑ β ∈ u.support, ((β k : ℝ)) * ‖u β‖ ^ 2 := by
    refine Finset.sum_subset (Finset.filter_subset _ _) ?_
    intro β hβu hβ
    have hz : β k = 0 := by
      by_contra hc
      exact hβ (Finset.mem_filter.mpr ⟨hβu, by omega⟩)
    simp [hz]
  rw [h1, h2, h3, h4, h5]
