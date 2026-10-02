-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.cFun_aFun_self
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (X : Vel → ℂ) :
    cFun i (aFun i X) = fun β => ((β i : ℝ) : ℂ) * X β := by

  funext β
  rcases Nat.eq_zero_or_pos (β i) with h0 | hpos
  · simp [cFun, h0]
  · have h1 : (1 : ℕ) ≤ β i := hpos
    have hcast : (((β i - 1 : ℕ) : ℝ) + 1) = ((β i : ℝ)) := by
      push_cast [Nat.cast_sub h1]
      ring
    simp only [cFun, aFun, lower_self, raise_lower i hpos, hcast]
    rw [← mul_assoc, ← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
