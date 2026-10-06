-- Generated from ChapterRadialMollifier.lean — theorem BookProof.RadialMollifier.moll_support_subset
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier



open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

theorem BookProof.RadialMollifier.moll_support_subset {δ : ℝ} (hδ : 0 < δ) :
    Function.support (moll δ) ⊆ ball (0 : ℂ) δ := by sorry
