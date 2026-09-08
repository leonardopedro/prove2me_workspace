-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.mulXPoly_eq
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) :
    (mulXPoly i : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
      = crePoly i + annPoly i := by

  refine LinearMap.ext fun p => ?_
  simp [mulXPoly, crePoly, annPoly]
