-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.gaussInt_self
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_QgHermiteFriedrichs_inner_pgLp_pgLp
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.GaussCoreQuadBounds




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock

noncomputable section

variable {D : ℕ}

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin D) ℂ) :
    gaussInt (cpoly q * q) = ((‖pgLp q‖ ^ 2 : ℝ) : ℂ) := by

  rw [← inner_pgLp_pgLp q q, inner_self_eq_norm_sq_to_K (𝕜 := ℂ) (pgLp q)]
  norm_cast
