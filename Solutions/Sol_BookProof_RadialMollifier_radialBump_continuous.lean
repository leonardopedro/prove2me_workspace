-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_continuous
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_radialBump_contDiff
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Continuous radialBump := radialBump_contDiff.continuous
