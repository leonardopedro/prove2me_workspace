-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.norm_sq_le_quadForm_harm
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

theorem BookProof.GaussCoreQuadBounds.norm_sq_le_quadForm_harm (p : MvPolynomial (Fin D) ℂ) :
    ((D : ℝ) / 2) * ‖pgLp p‖ ^ 2 ≤ quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ := by sorry
