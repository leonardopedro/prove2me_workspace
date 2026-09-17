-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.oscPoly_apply
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_momPoly_sq
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    oscPoly i p = X i * pderiv i p - pderiv i (pderiv i p) + (1/2 : ℂ) • p := by

  simp only [oscPoly, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    mulXPoly_apply, momPoly_sq]
  module
