-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.quadPoly_hermiteMv (c : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    quadPoly c (hermiteMv a) = ((quadSymbol c a : ℝ) : ℂ) • hermiteMv a := by sorry
