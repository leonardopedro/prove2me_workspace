-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.dcoord_cnv
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u ρ : Vd d → ℂ} (hu : LocallyIntegrable u (volume : Measure (Vd d)))
    (hρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ρ) (hc : HasCompactSupport ρ) (j : Fin d) :
    dcoord j (cnv u ρ) = cnv u (dcoord j ρ) := by

  funext x
  have h1 : HasFDerivAt (cnv u ρ)
      ((convolution u (fderiv ℝ ρ) ((ContinuousLinearMap.mul ℝ ℂ).precompR (Vd d)) volume) x) x :=
    hc.hasFDerivAt_convolution_right _ hu (hρ.of_le (by exact_mod_cast le_top)) x
  simp only [dcoord]
  rw [h1.fderiv]
  exact convolution_precompR_apply _ hu (hc.fderiv ℝ) (hρ.continuous_fderiv (by simp)) x _
