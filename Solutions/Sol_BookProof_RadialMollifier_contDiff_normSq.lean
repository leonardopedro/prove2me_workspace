-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.contDiff_normSq
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ContDiff ℝ ∞ (fun z : ℂ => Complex.normSq z) := by

  simp only [Complex.normSq_apply]
  exact (Complex.reCLM.contDiff.mul Complex.reCLM.contDiff).add
    (Complex.imCLM.contDiff.mul Complex.imCLM.contDiff)
