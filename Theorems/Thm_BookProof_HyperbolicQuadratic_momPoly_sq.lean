-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.momPoly_sq
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.momPoly_sq (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i (momPoly i p)
      = -(pderiv i (pderiv i p)) + (1/2 : ℂ) • p + X i * pderiv i p
        - (1/4 : ℂ) • (X i * (X i * p)) := by sorry
