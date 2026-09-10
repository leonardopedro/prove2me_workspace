-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.norm_harmPoly_mul_le_shiftNorm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_norm_harmP_le_shiftNorm
import Theorems.Thm_BookProof_GaussCoreQuadBounds_sqrt_dim_mul_norm_le_shiftNorm
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (harmPoly * p)‖ ≤ 2 * shiftNorm p := by

  have h := norm_harmPoly_mul_le p
  have h1 : ‖pgLp (kinPoly p + harmPoly * p)‖ ≤ shiftNorm p := norm_harmP_le_shiftNorm p
  have h2 := sqrt_dim_mul_norm_le_shiftNorm p
  linarith
