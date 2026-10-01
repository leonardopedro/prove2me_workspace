-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.inv_sqrt_two_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution : ((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ)
    = ((1 / 2 : ℝ) : ℂ) := by

  rw [← Complex.ofReal_mul]
  congr 1
  rw [div_mul_div_comm, one_mul, Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)]
