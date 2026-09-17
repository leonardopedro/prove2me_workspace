-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadSymbol_single
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.quadSymbol_single (c : Fin d → ℝ) (i : Fin d) (n : ℕ) :
    quadSymbol c (Finsupp.single i n) = c i * (n : ℝ) + ∑ j, c j * (1/2) := by sorry
