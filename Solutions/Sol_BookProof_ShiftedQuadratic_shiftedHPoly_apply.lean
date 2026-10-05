-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.shiftedHPoly_apply
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
open BookProof.ShiftedQuadratic




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
theorem solution (a k : Vd d) (c b b' : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    shiftedHPoly a k c b b' p
      = ∑ i, (((c i : ℝ) : ℂ) • oscTPoly a k i p + ((b i : ℝ) : ℂ) • mulXTPoly a i p
          + ((b' i : ℝ) : ℂ) • momTPoly k i p) := by

  simp [shiftedHPoly, LinearMap.sum_apply]
