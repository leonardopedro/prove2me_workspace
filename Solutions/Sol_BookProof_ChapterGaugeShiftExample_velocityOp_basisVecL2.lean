-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.velocityOp_basisVecL2
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) (j : ℤ) :
    velocityOp v (basisVecL2 j) = ((v : ℤ → ℝ) j : ℂ) • basisVecL2 j := by

  ext k
  simp only [velocityOp_apply, basisVecL2, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul,
    lp.single_apply, Pi.single_apply]
  by_cases h : k = j
  · rw [if_pos h, h]
  · rw [if_neg h, mul_zero, mul_zero]
