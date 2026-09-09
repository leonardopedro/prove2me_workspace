-- Generated from ChapterShiftedHermiteCore.lean — solution of BookProof.ShiftedHermiteCore.phaseFun_add
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
theorem solution (k x y : Vd d) : phaseFun k (x + y) = phaseFun k x * phaseFun k y := by

  rw [phaseFun, phaseFun, phaseFun, ← Complex.exp_add]
  congr 1
  have : phaseArg k (x + y) = phaseArg k x + phaseArg k y := by
    simp only [phaseArg, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => by simp [mul_add]
  rw [this]
  push_cast
  ring
