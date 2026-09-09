-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.temple_lower_bound
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_norm_apply_sq
import Theorems.Thm_BookProof_RitzCertificate_re_inner_factor
import Theorems.Thm_BookProof_RitzCertificate_factor_nonneg_of_separation
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ} {x : F}
    (hsep : SpectralSeparation A l b) (hx : ‖x‖ = 1) (hlt : rayleigh A x < b) :
    rayleigh A x - resid A x ^ 2 / (b - rayleigh A x) ≤ l := by

  set th := rayleigh A x with hth
  set eps := resid A x with heps
  have hpos := factor_nonneg_of_separation hA hsep
  have hquad0 := ((ContinuousLinearMap.nonneg_iff_isPositive _).mp hpos).inner_nonneg_right x
  have hquad : 0 ≤ (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
      (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ).re := by
    simpa only [Complex.zero_re] using (Complex.le_def.mp hquad0).1
  rw [re_inner_factor hA l b x, norm_apply_sq A x hx, hx] at hquad
  have hkey : (th - l) * (b - th) ≤ eps ^ 2 := by nlinarith [hquad]
  have hbth : 0 < b - th := by linarith
  have hdiv : th - l ≤ eps ^ 2 / (b - th) := (le_div_iff₀ hbth).mpr hkey
  linarith
