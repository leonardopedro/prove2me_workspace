-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_sum_le_of_pairwise
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_norm_sum_sq_eq
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_coe_sum_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)











open LpNat DiagonalEsa









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (cst : ℝ)
    (hc : 0 ≤ cst) (v : D)
    (hpair : ∀ k ∈ s, ∀ l ∈ s,
      |(inner ℂ ((h k v : D) : F) ((h l v : D) : F) : ℂ).re|
        ≤ cst ^ 2 * (inner ℂ ((n k v : D) : F) ((n l v : D) : F) : ℂ).re) :
    ‖(((∑ k ∈ s, h k) v : D) : F)‖ ≤ cst * ‖(((∑ k ∈ s, n k) v : D) : F)‖ := by

  have hL : ‖(((∑ k ∈ s, h k) v : D) : F)‖ ^ 2
      = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ ((h k v : D) : F) ((h l v : D) : F) : ℂ).re := by
    rw [coe_sum_apply s h v]
    exact norm_sum_sq_eq s fun k => ((h k v : D) : F)
  have hR : ‖(((∑ k ∈ s, n k) v : D) : F)‖ ^ 2
      = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ ((n k v : D) : F) ((n l v : D) : F) : ℂ).re := by
    rw [coe_sum_apply s n v]
    exact norm_sum_sq_eq s fun k => ((n k v : D) : F)
  have hsq : ‖(((∑ k ∈ s, h k) v : D) : F)‖ ^ 2
      ≤ cst ^ 2 * ‖(((∑ k ∈ s, n k) v : D) : F)‖ ^ 2 := by
    rw [hL, hR, Finset.mul_sum]
    refine Finset.sum_le_sum fun k hk => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun l hl => le_trans (le_abs_self _) (hpair k hk l hl)
  nlinarith [norm_nonneg (((∑ k ∈ s, h k) v : D) : F),
    norm_nonneg (((∑ k ∈ s, n k) v : D) : F),
    mul_nonneg hc (norm_nonneg (((∑ k ∈ s, n k) v : D) : F))]
