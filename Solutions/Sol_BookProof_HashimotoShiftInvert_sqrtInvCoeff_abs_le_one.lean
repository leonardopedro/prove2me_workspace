-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.sqrtInvCoeff_abs_le_one
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : |sqrtInvCoeff n| ≤ 1 := by

  have h0 : 0 ≤ sqrtInvCoeff n := Real.sqrt_nonneg _
  rw [abs_of_nonneg h0, sqrtInvCoeff]
  rw [show (1:ℝ) = Real.sqrt 1 by simp]
  exact Real.sqrt_le_sqrt (invCoeff_le_one n)
