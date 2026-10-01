-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.continuous_starobinskyV
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore




open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) : Continuous (starobinskyV M alpha) := by

  unfold starobinskyV
  fun_prop
