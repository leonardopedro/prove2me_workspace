-- Generated from ChapterH3.lean — solution of BookProof.ChapterH3.duhamel_scalar_smul
import Mathlib
import Definitions.Def_ChapterH3
import Theorems.Thm_BookProof_ChapterH3_duhamel_scalar
open BookProof.ChapterH3



open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (z g : ℂ) (δ : ℝ) :
    (∫ s in (0:ℝ)..δ, Complex.exp ((↑(δ - s)) * z) * g)
      = δ * BookProof.ChapterH1.phi 1 (δ * z) * g := by

  rw [intervalIntegral.integral_mul_const, duhamel_scalar]
