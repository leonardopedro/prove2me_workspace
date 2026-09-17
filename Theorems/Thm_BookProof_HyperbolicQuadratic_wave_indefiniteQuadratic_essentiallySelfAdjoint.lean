-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.wave_indefiniteQuadratic_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.wave_indefiniteQuadratic_essentiallySelfAdjoint (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1 + n)) (quadOp (minkowskiCoeff n)) := by sorry
