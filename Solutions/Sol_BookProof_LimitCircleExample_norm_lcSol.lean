-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.norm_lcSol
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : ‖lcSol x‖ = Real.exp (lcP x) := by

  rw [lcSol, Complex.norm_exp]
  congr 1
  simp
