-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.coreD_comm
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

theorem BookProof.GaussCoreQuadBounds.coreD_comm (j k : Fin D) (p : MvPolynomial (Fin D) ℂ) :
    coreD j (coreD k p) = coreD k (coreD j p) := by sorry
