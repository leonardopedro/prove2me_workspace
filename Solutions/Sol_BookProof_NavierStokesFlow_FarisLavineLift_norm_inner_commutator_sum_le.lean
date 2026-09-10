-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_inner_commutator_sum_le
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_coe_sum_apply
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_commDom_add_id
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_commDom_sum
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
theorem solution (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (c₂ : ℝ)
    (hc₂ : 0 ≤ c₂) (v : D)
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k))
    (hbound : ∀ k ∈ s, ‖(inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re) :
    ‖(inner ℂ ((v : F))
        ((commDom (∑ k ∈ s, h k) ((∑ k ∈ s, n k) + LinearMap.id) v : D) : F) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : F))
        ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F) : ℂ).re := by

  rw [commDom_add_id, commDom_sum s h n hcomm]
  have hleft : (inner ℂ ((v : F)) (((∑ k ∈ s, commDom (h k) (n k)) v : D) : F) : ℂ)
      = ∑ k ∈ s, (inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ) := by
    rw [coe_sum_apply s (fun k => commDom (h k) (n k)) v, inner_sum]
  have hright : (inner ℂ ((v : F))
        ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F) : ℂ).re
      = (∑ k ∈ s, (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re) + ‖(v : F)‖ ^ 2 := by
    have hcoe : ((((∑ k ∈ s, n k) + LinearMap.id : D →ₗ[ℂ] D) v : D) : F)
        = (∑ k ∈ s, ((n k v : D) : F)) + (v : F) := by
      simp
    rw [hcoe, inner_add_right, Complex.add_re, inner_sum, Complex.re_sum]
    congr 1
    simpa using inner_self_eq_norm_sq (𝕜 := ℂ) ((v : F))
  rw [hleft, hright]
  have habs : ‖∑ k ∈ s, (inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) : ℂ)‖
      ≤ ∑ k ∈ s, c₂ * (inner ℂ ((v : F)) ((n k v : D) : F) : ℂ).re :=
    le_trans (norm_sum_le _ _) (Finset.sum_le_sum hbound)
  have hsq : (0 : ℝ) ≤ c₂ * ‖(v : F)‖ ^ 2 := mul_nonneg hc₂ (sq_nonneg _)
  rw [← Finset.mul_sum] at habs
  nlinarith [habs, hsq]
