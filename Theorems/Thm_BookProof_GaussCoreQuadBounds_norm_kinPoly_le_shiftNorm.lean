-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.norm_kinPoly_le_shiftNorm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
open BookProof.GaussCoreQuadBounds

variable {D : ℕ}



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock

noncomputable section

variable {D : ℕ}

theorem BookProof.GaussCoreQuadBounds.norm_kinPoly_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (kinPoly p)‖ ≤ 3 * shiftNorm p := by sorry
