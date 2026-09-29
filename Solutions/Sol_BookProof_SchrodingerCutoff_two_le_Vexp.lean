-- Generated from ChapterSchrodingerCutoffEsa.lean — solution of BookProof.SchrodingerCutoff.two_le_Vexp
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff




open MeasureTheory Filter Complex

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : 2 ≤ Vexp x := by

  have hp : 0 < Real.exp x := Real.exp_pos x
  have hcancel : Real.exp x * (Real.exp x)⁻¹ = 1 := mul_inv_cancel₀ (ne_of_gt hp)
  rw [Vexp, Real.exp_neg]
  nlinarith [sq_nonneg (Real.exp x - 1), hp, hcancel]
