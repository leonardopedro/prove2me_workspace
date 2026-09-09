-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.norm_apply_sq
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (x : F) (hx : ‖x‖ = 1) :
    ‖A x‖ ^ 2 = resid A x ^ 2 + rayleigh A x ^ 2 := by

  have hsym : (inner ℂ (A x) x : ℂ).re = (inner ℂ x (A x) : ℂ).re := by
    rw [← inner_conj_symm (𝕜 := ℂ) x (A x), Complex.conj_re]
  have h := @norm_sub_sq ℂ F _ _ _ (A x) (((rayleigh A x : ℝ) : ℂ) • x)
  rw [resid, h, inner_smul_right, norm_smul]
  simp only [rayleigh, RCLike.mul_re, RCLike.re_to_complex, Complex.ofReal_re,
    RCLike.im_to_complex, Complex.ofReal_im, zero_mul, sub_zero, Complex.norm_real,
    Real.norm_eq_abs, hx, mul_one, sq_abs]
  rw [hsym]
  ring
