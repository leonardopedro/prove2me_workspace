-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.oscPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.oscPoly_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    oscPoly i (hermiteMv a) = (((a i : ℝ) : ℂ) + 1/2) • hermiteMv a := by sorry
