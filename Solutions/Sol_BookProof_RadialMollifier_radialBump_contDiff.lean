-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_contDiff
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_contDiff_normSq
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ContDiff ℝ ∞ radialBump := expNegInvGlue.contDiff.comp (contDiff_const.sub contDiff_normSq)
