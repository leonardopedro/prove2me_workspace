-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.cayley_real_multiplier
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
theorem solution {w : ℂ} (h : ‖w‖ ^ 2 = w.im) (hw : w ≠ 0) :
    1 + Complex.I * w = ((w.re / ‖w‖ ^ 2 : ℝ) : ℂ) * w := by

  have hsq : ‖w‖ ^ 2 = w.re ^ 2 + w.im ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq]
    simp [Complex.normSq_apply]
    ring
  have hb : w.im ≠ 0 := by
    intro hb0
    apply hw
    have h1 : ‖w‖ ^ 2 = 0 := by rw [h, hb0]
    have : ‖w‖ = 0 := by nlinarith [norm_nonneg w]
    exact norm_eq_zero.mp this
  have ha2 : w.re ^ 2 = w.im - w.im ^ 2 := by rw [hsq] at h; nlinarith [h]
  rw [h]
  have hcast : ((w.re / w.im : ℝ) : ℂ) = (w.re : ℂ) / (w.im : ℂ) := by push_cast; ring
  rw [hcast]
  have hbc : (w.im : ℂ) ≠ 0 := by exact_mod_cast hb
  field_simp
  rw [Complex.ext_iff]
  constructor <;> simp [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [ha2]
