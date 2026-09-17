-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.quadOp_essentiallySelfAdjoint (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOp c) := by sorry
