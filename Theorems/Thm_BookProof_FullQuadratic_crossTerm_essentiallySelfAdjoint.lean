-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.crossTerm_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.FullQuadratic

variable {d : ℕ}



open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.FullQuadratic.crossTerm_essentiallySelfAdjoint (S : Fin d → Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (fqOp 0 0 S 0 0) := by sorry
