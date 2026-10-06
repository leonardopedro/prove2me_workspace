-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.moll_integrable
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_moll_continuous
import Theorems.Thm_BookProof_RadialMollifier_moll_hasCompactSupport
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {δ : ℝ} (hδ : 0 < δ) : Integrable (moll δ) := (moll_continuous δ).integrable_of_hasCompactSupport (moll_hasCompactSupport hδ)
