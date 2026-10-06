-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.dbar_eq_zero_of_notMem_tsupport
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {φ : ℂ → ℂ} {z : ℂ} (hz : z ∉ tsupport φ) :
    dbar φ z = 0 := by

  have h0 : φ =ᶠ[𝓝 z] fun _ => 0 := by
    filter_upwards [(isOpen_compl_iff.2 (isClosed_tsupport φ)).mem_nhds hz] with w hw
    exact image_eq_zero_of_notMem_tsupport hw
  simp only [dbar, h0.fderiv_eq]
  simp
