-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.norm_harmP_le_shiftNorm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_quadForm_harm_nonneg
import Theorems.Thm_BookProof_GaussCoreQuadBounds_shiftNorm_sq
import Theorems.Thm_BookProof_GaussCoreQuadBounds_shiftNorm_nonneg
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (harmP p)‖ ≤ shiftNorm p := by

  have hsq := shiftNorm_sq p
  have hq := quadForm_harm_nonneg p
  nlinarith [norm_nonneg (pgLp p), shiftNorm_nonneg p, norm_nonneg (pgLp (harmP p))]
