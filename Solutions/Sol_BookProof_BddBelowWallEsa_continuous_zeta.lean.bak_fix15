-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.continuous_zeta
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_hasDerivAt_zeta
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) : Continuous (zeta r) := continuous_iff_continuousAt.2 fun x => (hasDerivAt_zeta r x).continuousAt
