-- Generated from ChapterOrthogonalSums.lean — solution of BookProof.ChapterOrthogonalSums.hasSum_norm_sq_of_hasSum
import Mathlib
import Definitions.Def_ChapterOrthogonalSums
open BookProof.ChapterOrthogonalSums



open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} {v : ι → E} {psi : E} (h : HasSum v psi)
    (horth : ∀ x y, x ≠ y → ⟪v x, v y⟫_ℂ = 0) :
    HasSum (fun x => ‖v x‖ ^ 2) (‖psi‖ ^ 2) := by

  have hterm : ∀ x, ⟪psi, v x⟫_ℂ = ((‖v x‖ ^ 2 : ℝ) : ℂ) := by
    intro x
    have hx : HasSum (fun y => ⟪v x, v y⟫_ℂ) ⟪v x, psi⟫_ℂ := h.mapL (innerSL ℂ (v x))
    have hx' : HasSum (fun y => ⟪v x, v y⟫_ℂ) ⟪v x, v x⟫_ℂ := by
      refine hasSum_single x ?_
      intro y hy
      exact horth x y (Ne.symm hy)
    have hxx : ⟪v x, psi⟫_ℂ = ⟪v x, v x⟫_ℂ := hx.unique hx'
    rw [← inner_conj_symm, hxx, inner_self_eq_norm_sq_to_K]
    simp
  have h1 : HasSum (fun x => ⟪psi, v x⟫_ℂ) ⟪psi, psi⟫_ℂ := h.mapL (innerSL ℂ psi)
  rw [inner_self_eq_norm_sq_to_K] at h1
  simp only [hterm] at h1
  have h2 := h1.mapL Complex.reCLM
  simpa [← Complex.ofReal_pow] using h2
