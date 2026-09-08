-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteR_ode
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    derivative (derivative (hermiteR n)) - X * derivative (hermiteR n) + C (n : ℝ) * hermiteR n
      = 0 := by

  have h := derivative_hermiteR n
  rw [hermiteR_succ n, derivative_sub, derivative_mul, derivative_X] at h
  have hC : (C ((n : ℝ) + 1) : Polynomial ℝ) = C (n : ℝ) + 1 := by rw [map_add, map_one]
  rw [hC] at h
  linear_combination -h
