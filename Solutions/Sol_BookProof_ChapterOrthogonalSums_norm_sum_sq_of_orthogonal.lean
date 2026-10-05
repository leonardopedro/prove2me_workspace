-- Generated from ChapterOrthogonalSums.lean — solution of BookProof.ChapterOrthogonalSums.norm_sum_sq_of_orthogonal
import Mathlib
import Definitions.Def_ChapterOrthogonalSums
open BookProof.ChapterOrthogonalSums



open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (t : Finset ι) {v : ι → E}
    (horth : ∀ x y, x ≠ y → ⟪v x, v y⟫_ℂ = 0) :
    ‖∑ x ∈ t, v x‖ ^ 2 = ∑ x ∈ t, ‖v x‖ ^ 2 := by

  have hip : ⟪∑ x ∈ t, v x, ∑ x ∈ t, v x⟫_ℂ = ∑ x ∈ t, ⟪v x, v x⟫_ℂ := by
    rw [sum_inner]
    refine Finset.sum_congr rfl fun x hx => ?_
    rw [inner_sum, Finset.sum_eq_single x]
    · intro y _ hy
      exact horth x y (Ne.symm hy)
    · intro h
      exact absurd hx h
  have h2 := congrArg (RCLike.re (K := ℂ)) hip
  rw [map_sum] at h2
  simp only [inner_self_eq_norm_sq] at h2
  exact h2
