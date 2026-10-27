-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfQ'
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : HasDerivAt cfQ' (-Real.exp (-y)) y := by

  have h := ((hasDerivAt_neg y).exp).const_add (1 : ℝ)
  have hfun : (fun t : ℝ => 1 + Real.exp (-t)) = cfQ' := rfl
  rw [hfun] at h
  have hval : Real.exp (-y) * -1 = -Real.exp (-y) := by ring
  rw [hval] at h
  exact h
