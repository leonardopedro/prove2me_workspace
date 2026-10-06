-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.shiftOp_basisVecL2
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (m j : ℤ) :
    shiftOp m (basisVecL2 j) = basisVecL2 (j - m) := by

  ext k
  simp only [shiftOp_apply, basisVecL2, lp.single_apply, Pi.single_apply]
  by_cases h : k = j - m
  · have h2 : k + m = j := by omega
    rw [if_pos h, if_pos h2]
  · have h2 : k + m ≠ j := by omega
    rw [if_neg h, if_neg h2]
