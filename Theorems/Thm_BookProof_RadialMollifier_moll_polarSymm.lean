-- Generated from ChapterRadialMollifier.lean — theorem BookProof.RadialMollifier.moll_polarSymm
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier



open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

theorem BookProof.RadialMollifier.moll_polarSymm {δ r θ : ℝ} (hr : 0 < r) :
    moll δ (Complex.polarCoord.symm (r, θ)) = moll δ (r : ℂ) := by sorry
