-- Generated from ChapterSchrodingerCutoffEsa.lean — solution of BookProof.SchrodingerCutoff.exists_deriv_chi_bound
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
import Theorems.Thm_BookProof_SchrodingerCutoff_deriv_chi_continuous
open BookProof.SchrodingerCutoff




open MeasureTheory Filter Complex

set_option maxHeartbeats 1000000 in
theorem solution : ∃ C : ℝ, 0 < C ∧ ∀ y, |deriv chi y| ≤ C := by

  have hc : Continuous fun y => |deriv chi y| := deriv_chi_continuous.abs
  have hs : HasCompactSupport fun y => |deriv chi y| :=
    (bump0.hasCompactSupport.deriv).abs
  obtain ⟨y0, hy0⟩ := hc.exists_forall_ge_of_hasCompactSupport hs
  exact ⟨|deriv chi y0| + 1, by positivity, fun y => by linarith [hy0 y]⟩
