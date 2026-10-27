-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.angularMomentum_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
open BookProof.FullQuadratic




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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k l : Fin d) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (fqOp 0 0 (rotMat k l) 0 0) := fqOp_essentiallySelfAdjoint 0 0 (rotMat k l) 0 0
