-- Generated from ChapterShiftedHermiteCore.lean — solution of BookProof.ShiftedHermiteCore.pgMapT_apply
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedHermiteCore











open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    pgMapT a k p = pgLpT a k p := rfl
