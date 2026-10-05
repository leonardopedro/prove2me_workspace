-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.dPolyT_apply
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    dPolyT k i p = dPoly i p + (Complex.I * ((k i : ℝ) : ℂ)) • p := rfl
