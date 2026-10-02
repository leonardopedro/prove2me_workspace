-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.aFun_cFun_self
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (X : Vel → ℂ) :
    aFun i (cFun i X) = fun β => (((β i : ℝ) + 1 : ℝ) : ℂ) * X β := by

  funext β
  simp only [aFun, cFun, raise_self, lower_raise]
  rw [show ((β i + 1 : ℕ) : ℝ) = ((β i : ℝ) + 1) from by push_cast; ring,
    ← mul_assoc, ← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
