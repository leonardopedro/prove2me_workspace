-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.quadForm_harm_eq
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

theorem BookProof.GaussCoreQuadBounds.quadForm_harm_eq (p : MvPolynomial (Fin D) ℂ) :
    quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩
      = ∑ j : Fin D, (‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4) := by sorry
