-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.ae_eq_zero_of_moments
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_gaussH_pos
import Theorems.Thm_BookProof_HermiteCore_memLp_poly_mul_gaussH
import Theorems.Thm_BookProof_HermiteCore_ae_eq_zero_of_fourier_eq_zero
import Theorems.Thm_BookProof_HermiteCore_fourier_gaussH_mul_eq_zero
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
    = 0 := by
    have hc : Filter.Tendsto (fun _ : ℕ => (0 : ℂ)) Filter.atTop
        (nhds (∫ x : ℝ, Complex.exp (Complex.I * (a : ℂ) * (x : ℂ))
          * (((gaussH x : ℝ) : ℂ) * u x))) := by
      simpa [hFint] using hconv
    exact tendsto :=
  _nhds_unique hc tendsto_const_nhds
    rw [Real.fourier_real_eq_integral_exp_smul, ← hval]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [smul_eq_mul]
    congr 2
    rw [ha]
    push_cast
    ring
  
  /-- **Vanishing of all Gaussian moments forces `u = 0`.** -/
  theorem ae_eq_zero_of_moments {u : ℝ → ℂ} (hu : MemLp u 2 (volume : Measure ℝ))
      (hmom : ∀ k : ℕ, ∫ x : ℝ, ((x ^ k * gaussH x : ℝ) : ℂ) * u x = 0) :
      ∀ᵐ x : ℝ, u x = 0 := by
    have hg : MemLp (fun x : ℝ => ((gaussH x
