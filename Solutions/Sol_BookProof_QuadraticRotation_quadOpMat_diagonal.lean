-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.quadOpMat_diagonal
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_quadPolyMat_diagonal
open BookProof.QuadraticRotation




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) :
    quadOpMat (Matrix.diagonal c) = quadOp c := by

  rw [quadOpMat, quadOp, quadPolyMat_diagonal]
