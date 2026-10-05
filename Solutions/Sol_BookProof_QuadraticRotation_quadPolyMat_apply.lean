-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.quadPolyMat_apply
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
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
theorem solution (A : Matrix (Fin d) (Fin d) ℝ) (p : MvPolynomial (Fin d) ℂ) :
    quadPolyMat A p = ∑ k, ∑ l, ((A k l : ℝ) : ℂ) •
      (momPoly k (momPoly l p) + (1/4 : ℂ) • (X k * (X l * p))) := by

  simp [quadPolyMat, LinearMap.sum_apply]
