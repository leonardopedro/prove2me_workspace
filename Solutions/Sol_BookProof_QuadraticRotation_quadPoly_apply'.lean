-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.quadPoly_apply'
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
theorem solution (c : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    quadPoly c p = ∑ i, ((c i : ℝ) : ℂ) •
      (momPoly i (momPoly i p) + (1/4 : ℂ) • (X i * (X i * p))) := by

  simp [quadPoly, oscPoly, LinearMap.sum_apply]
