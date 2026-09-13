-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.re_inner_factor
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Theorems.Thm_BookProof_RitzCertificate_isSelfAdjoint_sub_const
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterBandEnclosure
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (l b : ℝ) (x : F) :
    (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
        (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ).re
      = ‖A x‖ ^ 2 - (l + b) * rayleigh A x + l * b * ‖x‖ ^ 2 := by

  have hsym : (inner ℂ (A x) x : ℂ).re = (inner ℂ x (A x) : ℂ).re := by
    rw [← inner_conj_symm (𝕜 := ℂ) x (A x), Complex.conj_re]
  have hPx : (A - (l : ℝ) • (1 : F →L[ℂ] F)) x = A x - (l : ℂ) • x := by simp
  have hQx : (A - (b : ℝ) • (1 : F →L[ℂ] F)) x = A x - (b : ℂ) • x := by simp
  have hmove : (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
        (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ)
      = inner ℂ ((A - (l : ℝ) • (1 : F →L[ℂ] F)) x)
          ((A - (b : ℝ) • (1 : F →L[ℂ] F)) x) := by
    rw [ContinuousLinearMap.mul_apply, ← ContinuousLinearMap.adjoint_inner_left,
      (isSelfAdjoint_sub_const hA l).adjoint_eq]
  rw [hmove, hPx, hQx, rayleigh]
  simp [inner_self_eq_norm_sq_to_K, Complex.sub_re, Complex.mul_re, hsym,
    ← Complex.ofReal_pow]
  ring_nf
