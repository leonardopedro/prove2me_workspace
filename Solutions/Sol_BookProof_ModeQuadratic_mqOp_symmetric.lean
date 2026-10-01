-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.mqOp_symmetric
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_polySym_mqPoly
import Theorems.Thm_BookProof_HermiteRelative_symmetricOn_of_polySym
open BookProof.ModeQuadratic




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

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1600000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem solution (p q s b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (mqOp p q s b b') := symmetricOn_of_polySym (polySym_mqPoly p q s b b')
