-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.mulXPoly_eq_lop
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : mulXPoly (d := d) i = lop 1 i := by

  refine LinearMap.ext fun p => ?_
  simp only [lop, LinearMap.add_apply, crePoly_apply, annPoly_apply,
    mulXPoly_apply, one_smul]
  ring
