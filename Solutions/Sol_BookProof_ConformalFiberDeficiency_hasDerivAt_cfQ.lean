-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfQ
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : HasDerivAt cfQ (cfQ' y) y := by

  have h := (hasDerivAt_id y).sub ((hasDerivAt_neg y).exp)
  have heq : 1 - Real.exp (-y) * -1 = cfQ' y := by unfold cfQ'; ring
  show HasDerivAt (fun t : ℝ => t - Real.exp (-t)) _ y
  rwa [heq] at h
