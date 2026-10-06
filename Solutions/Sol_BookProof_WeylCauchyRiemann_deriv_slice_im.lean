-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.deriv_slice_im
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ψ : ℂ → ℂ} (hψ : Differentiable ℝ ψ) (x y : ℝ) :
    deriv (fun t : ℝ => ψ ((x : ℂ) + t * Complex.I)) y
      = fderiv ℝ ψ ((x : ℂ) + y * Complex.I) Complex.I := by

  have hg : HasDerivAt (fun t : ℝ => (x : ℂ) + t * Complex.I) Complex.I y := by
    simpa using ((Complex.ofRealCLM.hasDerivAt (x := y)).mul_const Complex.I).const_add
      ((x : ℂ))
  have := (hψ ((x : ℂ) + y * Complex.I)).hasFDerivAt.comp_hasDerivAt y hg
  exact this.deriv
