-- Generated from ChapterAngularMomentum.lean — solution of BookProof.ChapterAngularMomentum.fderiv_rotationVector
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum




open Complex

set_option maxHeartbeats 1000000 in
theorem solution (u : ℂ → ℂ) (z : ℂ) :
    fderiv ℝ u z (Complex.I * z)
      = z.re * fderiv ℝ u z Complex.I - z.im * fderiv ℝ u z 1 := by

  have hz : Complex.I * z = z.re • Complex.I + (-z.im) • (1 : ℂ) := by
    apply Complex.ext <;> simp
  rw [hz, map_add, map_smul, map_smul]
  simp [sub_eq_add_neg]
