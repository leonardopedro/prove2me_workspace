-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.mqOp_symmetric
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

set_option maxHeartbeats 1600000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem BookProof.ModeQuadratic.mqOp_symmetric (p q s b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (mqOp p q s b b') := by sorry
