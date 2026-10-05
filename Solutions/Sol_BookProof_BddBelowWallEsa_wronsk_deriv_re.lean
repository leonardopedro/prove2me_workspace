-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.wronsk_deriv_re
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) :
    ((starRingEnd ℂ) (W' x) * W' x
        + (starRingEnd ℂ) (W x) * ((((V x : ℝ) : ℂ) - z) * W x)).re
      = ‖W' x‖ ^ 2 + (V x - z.re) * ‖W x‖ ^ 2 := by

  have h1 : (starRingEnd ℂ) (W' x) * W' x = ((‖W' x‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.conj_mul']; push_cast; ring
  have h2 : (starRingEnd ℂ) (W x) * ((((V x : ℝ) : ℂ) - z) * W x)
      = ((((V x : ℝ) : ℂ) - z)) * ((‖W x‖ ^ 2 : ℝ) : ℂ) := by
    rw [← mul_assoc, mul_comm ((starRingEnd ℂ) (W x)) ((((V x : ℝ) : ℂ) - z)), mul_assoc,
      Complex.conj_mul']
    push_cast; ring
  rw [h1, h2]
  simp only [Complex.add_re, Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.ofReal_re,
    Complex.ofReal_im]
  ring
