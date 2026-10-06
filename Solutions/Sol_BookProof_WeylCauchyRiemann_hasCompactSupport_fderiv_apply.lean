-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.hasCompactSupport_fderiv_apply
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (v : ℂ) :
    HasCompactSupport (fun z : ℂ => fderiv ℝ ψ z v) := by

  refine HasCompactSupport.of_support_subset_isCompact hψc.isCompact ?_
  intro z hz
  have : fderiv ℝ ψ z ≠ 0 := by
    intro h
    apply hz
    simp [h]
  exact support_fderiv_subset ℝ (f := ψ) this
