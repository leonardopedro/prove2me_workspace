-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.dilation_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
open BookProof.ModeQuadratic

variable {d : ℕ}



open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.ModeQuadratic.dilation_essentiallySelfAdjoint :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (mqOp 0 0 1 0 0) := by sorry
