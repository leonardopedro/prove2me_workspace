-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.inner_harmP_re
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_re_inner_symm
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    (inner ℂ (pgLp (harmP p)) (pgLp p) : ℂ).re
      = quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ := by

  have h : quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩
      = (inner ℂ (pgLp p) (pgLp (harmP p)) : ℂ).re := by
    rw [quadForm, harmCore_pgLp]
    rfl
  rw [h, re_inner_symm]
