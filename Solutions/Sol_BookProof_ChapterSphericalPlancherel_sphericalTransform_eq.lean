-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.sphericalTransform_eq
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
import Theorems.Thm_BookProof_ChapterSphericalBessel_sbessel_zero
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution {f : ℝ → ℂ} {G : ℝ → ℂ}
    (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) {p : ℝ} (hp : 0 < p) :
    sphericalTransform f p
      = (Real.sqrt (2 / π) : ℂ) * ((p : ℂ)⁻¹ * sineKernelTransform G p) := by

  have hint : (∫ r in Ioi (0 : ℝ), f r * (sbessel 0 (p * r) : ℂ) * (r : ℂ) ^ 2)
      = (p : ℂ)⁻¹ * sineKernelTransform G p := by
    rw [sineKernelTransform, ← MeasureTheory.integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioi fun r hr => ?_
    have hrpos : (0 : ℝ) < r := mem_Ioi.mp hr
    have hrC : (r : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hrpos.ne'
    have hpC : (p : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hp.ne'
    have hb : (sbessel 0 (p * r) : ℂ) = (Real.sin (p * r) : ℂ) / ((p : ℂ) * (r : ℂ)) := by
      rw [sbessel_zero]
      simp only [sj0]
      push_cast
      ring
    rw [hb, ← hf r hr]
    field_simp
  rw [sphericalTransform, hint]
