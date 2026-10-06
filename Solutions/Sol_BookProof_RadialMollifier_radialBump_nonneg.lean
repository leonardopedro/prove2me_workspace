-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_nonneg
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (z : ℂ) : 0 ≤ radialBump z := expNegInvGlue.nonneg _
