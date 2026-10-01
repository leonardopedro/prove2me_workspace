-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.norm_weighted_kin_sq
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

theorem BookProof.GaussCoreQuadBounds.norm_weighted_kin_sq (c : Fin D → ℝ) (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (∑ j : Fin D, ((c j : ℝ) : ℂ) • coreD j (coreD j p))‖ ^ 2
      = ∑ j : Fin D, ∑ k : Fin D, c j * c k * ‖pgLp (coreD k (coreD j p))‖ ^ 2 := by sorry
