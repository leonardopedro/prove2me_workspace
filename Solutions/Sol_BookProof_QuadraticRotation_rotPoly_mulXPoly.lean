-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotPoly_mulXPoly
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_X
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
theorem solution (O : Matrix (Fin d) (Fin d) ℝ) (i : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (mulXPoly i p) = ∑ k, ((O k i : ℝ) : ℂ) • mulXPoly k (rotPoly O p) := by

  simp only [mulXPoly_apply, map_mul, rotPoly_X, Finset.sum_mul]
  exact Finset.sum_congr rfl fun k _ => by rw [MvPolynomial.smul_eq_C_mul, mul_assoc]
