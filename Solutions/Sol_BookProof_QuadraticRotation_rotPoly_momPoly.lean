-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotPoly_momPoly
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_C
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_mulXPoly
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_pderiv
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_momPoly_apply
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
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (i : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (momPoly i p) = ∑ k, ((O k i : ℝ) : ℂ) • momPoly k (rotPoly O p) := by

  have hX : rotPoly O (X i * p) = ∑ k, ((O k i : ℝ) : ℂ) • (X k * rotPoly O p) := by
    simpa using rotPoly_mulXPoly O i p
  rw [momPoly_apply, map_mul, rotPoly_C, map_sub, map_mul, rotPoly_C, rotPoly_pderiv hO, hX,
    Finset.mul_sum, ← Finset.sum_sub_distrib, Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  simp only [momPoly_apply, MvPolynomial.smul_eq_C_mul]
  ring
