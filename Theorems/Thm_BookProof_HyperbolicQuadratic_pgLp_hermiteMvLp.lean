-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.pgLp_hermiteMvLp
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.pgLp_hermiteMvLp (a : Fin d →₀ ℕ) :
    pgLp (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a) = hermiteMvLp a := by sorry
