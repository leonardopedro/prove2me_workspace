-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.deriv_slice_re
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ψ : ℂ → ℂ} (hψ : Differentiable ℝ ψ) (x y : ℝ) :
    deriv (fun t : ℝ => ψ ((t : ℂ) + y * Complex.I)) x
      = fderiv ℝ ψ ((x : ℂ) + y * Complex.I) 1 := by

  have hg : HasDerivAt (fun t : ℝ => (t : ℂ) + y * Complex.I) 1 x := by
    simpa using (Complex.ofRealCLM.hasDerivAt (x := x)).add_const ((y : ℂ) * Complex.I)
  have := (hψ ((x : ℂ) + y * Complex.I)).hasFDerivAt.comp_hasDerivAt x hg
  exact this.deriv
