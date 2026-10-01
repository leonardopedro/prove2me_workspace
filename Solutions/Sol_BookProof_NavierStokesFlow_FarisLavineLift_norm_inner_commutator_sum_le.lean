-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_inner_commutator_sum_le
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_commDom_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_coe_sum_apply
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_commDom_add_id
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

set_option maxHeartbeats 1000000 in
   intro k hk
    rw [Finset.sum_eq_single_of_mem k hk]
    · simp [commDom]
    · intro l hl hlk
      have := hcomm k hk l hl (Ne.symm hlk)
      have happ := congrArg (fun T : D →ₗ[ℂ] D => T v) this
      simp only [LinearMap.comp_apply] at happ
      rw [happ]
      simp
  rw [Finset.sum_congr rfl hdiag]
  simp

theorem solution (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (c₂ : ℝ)
    (hc₂ : 0 ≤ c₂) (v : D)
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k))
    (hbound : ∀ k ∈ s, ‖(inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) :=
  : ℂ)‖
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
    have habs : ‖∑ k ∈ s, (inner ℂ ((v : F)) (
