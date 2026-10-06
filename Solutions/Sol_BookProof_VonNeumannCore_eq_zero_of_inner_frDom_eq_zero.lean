-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.eq_zero_of_inner_frDom_eq_zero
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_factorRel_witness
import Theorems.Thm_BookProof_ClosureUniqueness_mem_adjGraph_iff
import Theorems.Thm_BookProof_FriedrichsSquare_exists_mem_factorRel_add
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) {x : F}
    (hx : ∀ u ∈ frDom A, (inner ℂ u x : ℂ) = 0) : x = 0 := by

  obtain ⟨p, hp, hsum⟩ := exists_mem_factorRel_add A x
  obtain ⟨y, hy, hz, hval⟩ := factorRel_witness hp
  have hx1 : (inner ℂ p.1 x : ℂ) = 0 := hx p.1 (mem_frDom_iff.2 ⟨p.2, hp⟩)
  have hquad : (inner ℂ p.1 (p.1 + p.2) : ℂ) = ((‖p.1‖ ^ 2 + ‖y‖ ^ 2 : ℝ) : ℂ) := by
    have h1 : (inner ℂ p.1 p.1 : ℂ) = ((‖p.1‖ ^ 2 : ℝ) : ℂ) := by
      rw [inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [inner_add_right, h1, hval, ← Complex.ofReal_add]
  rw [hsum, hx1] at hquad
  have hre : (0 : ℝ) = ‖p.1‖ ^ 2 + ‖y‖ ^ 2 := by
    have h0 := congrArg Complex.re hquad
    rwa [Complex.zero_re, Complex.ofReal_re] at h0
  have hp1 : p.1 = 0 := by
    have : ‖p.1‖ = 0 := by nlinarith [norm_nonneg p.1, norm_nonneg y]
    simpa using this
  have hy0 : y = 0 := by
    have : ‖y‖ = 0 := by nlinarith [norm_nonneg p.1, norm_nonneg y]
    simpa using this
  have hp2 : p.2 = 0 := by
    rw [mem_adjGraph_iff] at hz
    refine Dense.eq_zero_of_inner_right ℂ hdense fun v hv => ?_
    have hv' := hz ⟨v, hv⟩
    simp only [hy0, inner_zero_right] at hv'
    exact hv'.symm
  rw [← hsum, hp1, hp2, add_zero]
