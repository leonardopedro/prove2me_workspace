-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.cayley_pointwise
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (w : ℂ) :
    w - (starRingEnd ℂ) w - (2 * Complex.I) * ((starRingEnd ℂ) w * w)
      = (2 * Complex.I) * (((w.im - ‖w‖ ^ 2 : ℝ) : ℂ)) := by

  have h : ‖w‖ ^ 2 = w.re ^ 2 + w.im ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq]
    simp [Complex.normSq_apply]
    ring
  simp only [Complex.ext_iff, h, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im,
    Complex.I_re, Complex.I_im, Complex.conj_re, Complex.conj_im, Complex.ofReal_re,
    Complex.ofReal_im, Complex.re_ofNat, Complex.im_ofNat]
  constructor <;> ring
