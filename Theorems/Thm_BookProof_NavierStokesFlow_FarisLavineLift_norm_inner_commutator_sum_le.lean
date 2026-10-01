-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_inner_commutator_sum_le
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}




open FullEsa

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

theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_inner_commutator_sum_le (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D)) (c₂ : ℝ)
    (hc₂ : 0 ≤ c₂) (v : D)
    (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k))
    (hbound : ∀ k ∈ s, ‖(inner ℂ ((v : F)) ((commDom (h k) (n k) v : D) : F) := by sorry
