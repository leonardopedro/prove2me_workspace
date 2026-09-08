-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.momPoly_eq
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) :
    (momPoly i : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
      = (Complex.I / 2) • crePoly i + (-(Complex.I / 2)) • annPoly i := by

  refine LinearMap.ext fun p => ?_
  have h1 : (C (-Complex.I) : MvPolynomial (Fin d) ℂ) * (pderiv i p - C (1/2 : ℂ) * (X i * p))
      = (-Complex.I) • (pderiv i p - (1/2 : ℂ) • (X i * p)) := by
    rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul]
  simp only [LinearMap.add_apply, LinearMap.smul_apply, momPoly_apply, crePoly_apply,
    annPoly_apply, h1]
  module
