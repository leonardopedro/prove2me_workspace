-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_sum_sq_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {κ : Type*} (s : Finset κ) (a : κ → F) :
    ‖∑ k ∈ s, a k‖ ^ 2 = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ (a k) (a l) : ℂ).re := by

  have hinner : (inner ℂ (∑ k ∈ s, a k) (∑ l ∈ s, a l) : ℂ)
      = ∑ k ∈ s, ∑ l ∈ s, (inner ℂ (a k) (a l) : ℂ) := by
    rw [sum_inner]
    exact Finset.sum_congr rfl fun k _ => inner_sum _ _ _
  have hnorm : ‖∑ k ∈ s, a k‖ ^ 2 = (inner ℂ (∑ k ∈ s, a k) (∑ k ∈ s, a k) : ℂ).re := by
    simpa using (inner_self_eq_norm_sq (𝕜 := ℂ) (∑ k ∈ s, a k)).symm
  rw [hnorm, hinner, Complex.re_sum]
  exact Finset.sum_congr rfl fun k _ => Complex.re_sum _ _
