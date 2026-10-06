-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.moll_polarSymm
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_moll_congr_norm
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {δ r θ : ℝ} (hr : 0 < r) :
    moll δ (Complex.polarCoord.symm (r, θ)) = moll δ (r : ℂ) := by

  refine moll_congr_norm ?_
  rw [Complex.norm_polarCoord_symm]
  simp [abs_of_pos hr]
