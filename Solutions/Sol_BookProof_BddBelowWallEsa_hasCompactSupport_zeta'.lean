-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.hasCompactSupport_zeta'
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_zeta
import Theorems.Thm_BookProof_BddBelowWallEsa_hasCompactSupport_zeta
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : 0 < r) : HasCompactSupport (zeta' r) := by

  have h : zeta' r = deriv (zeta r) := funext fun x => (hasDerivAt_zeta r x).deriv.symm
  rw [h]
  exact (hasCompactSupport_zeta hr).deriv
