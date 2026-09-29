-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.sqrt_dim_mul_norm_le_shiftNorm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_dim_mul_norm_le_shiftNorm
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    Real.sqrt ((D : ℝ) / 2) * ‖pgLp p‖ ≤ shiftNorm p := by

  have hsqrt : Real.sqrt ((D : ℝ) / 2) ≤ (D : ℝ) / 2 + 1 := by
    have h1 : ((D : ℝ) / 2 + 1) = Real.sqrt (((D : ℝ) / 2 + 1) ^ 2) :=
      (Real.sqrt_sq (by positivity)).symm
    rw [h1]
    exact Real.sqrt_le_sqrt (by nlinarith [Nat.cast_nonneg (α := ℝ) D])
  refine le_trans (mul_le_mul_of_nonneg_right hsqrt (norm_nonneg _)) ?_
  exact dim_mul_norm_le_shiftNorm p
