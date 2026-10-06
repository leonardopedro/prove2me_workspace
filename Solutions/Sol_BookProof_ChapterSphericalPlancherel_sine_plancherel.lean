-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.sine_plancherel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
import Theorems.Thm_BookProof_ChapterSphericalPlancherel_integral_eq_two_mul_of_even_real
import Theorems.Thm_BookProof_ChapterSphericalPlancherel_sineTransform_odd
import Theorems.Thm_BookProof_ChapterSphericalPlancherel_fourier_odd_eq
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x) :
    ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2
      = (1 / 4) * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 := by

  have hP : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = ∫ x : ℝ, ‖G x‖ ^ 2 :=
    SchwartzMap.integral_norm_sq_fourier G
  have hFl : ∀ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2 = 4 * ‖sineTransform (⇑G) w‖ ^ 2 := by
    intro w
    rw [fourier_odd_eq _ G.integrable hodd, norm_mul]
    simp [mul_pow]
    norm_num
  have hL : ∫ w : ℝ, ‖𝓕 (⇑G) w‖ ^ 2
      = 2 * (4 * ∫ w in Ioi (0 : ℝ), ‖sineTransform (⇑G) w‖ ^ 2) := by
    rw [integral_eq_two_mul_of_even_real _
      fun w => by rw [hFl, hFl, sineTransform_odd, norm_neg]]
    simp_rw [hFl]
    rw [integral_const_mul]
  have hR : ∫ x : ℝ, ‖G x‖ ^ 2 = 2 * ∫ x in Ioi (0 : ℝ), ‖G x‖ ^ 2 :=
    integral_eq_two_mul_of_even_real _ fun x => by rw [hodd, norm_neg]
  rw [hL, hR] at hP
  linarith
