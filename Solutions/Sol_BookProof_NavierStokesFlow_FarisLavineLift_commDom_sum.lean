-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.commDom_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
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
theorem solution (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D))
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k)) :
    commDom (∑ k ∈ s, h k) (∑ k ∈ s, n k) = ∑ k ∈ s, commDom (h k) (n k) := by

  ext v
  have hexp : (commDom (∑ k ∈ s, h k) (∑ k ∈ s, n k)) v
      = ∑ k ∈ s, ∑ l ∈ s, (h k (n l v) - n l (h k v)) := by
    simp only [commDom, LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.sum_apply, map_sum,
      Finset.sum_sub_distrib]
    congr 1
    exact Finset.sum_comm
  rw [hexp]
  have hdiag : ∀ k ∈ s, ∑ l ∈ s, (h k (n l v) - n l (h k v)) = commDom (h k) (n k) v := by
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
