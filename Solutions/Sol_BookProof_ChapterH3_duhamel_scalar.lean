-- Generated from ChapterH3.lean — solution of BookProof.ChapterH3.duhamel_scalar
import Mathlib
import Definitions.Def_ChapterH3
open BookProof.ChapterH3



open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (z : ℂ) (δ : ℝ) :
    (∫ s in (0:ℝ)..δ, Complex.exp ((↑(δ - s)) * z))
      = δ * BookProof.ChapterH1.phi 1 (δ * z) := by

  have hL : (∫ s in (0:ℝ)..δ, Complex.exp ((↑(δ - s)) * z))
      = ∫ u in (0:ℝ)..δ, Complex.exp ((u:ℂ) * z) := by
    have := intervalIntegral.integral_comp_sub_left (a := 0) (b := δ)
      (f := fun u : ℝ => Complex.exp ((u:ℂ) * z)) δ
    simpa using this
  rw [hL]
  unfold BookProof.ChapterH1.phi
  simp only [pow_zero, Nat.factorial_zero, Nat.cast_one, div_one, mul_one]
  by_cases hδ : δ = 0
  · simp [hδ]
  · have hc : ∫ s in (0:ℝ)..1, Complex.exp ((s:ℂ) * ((δ:ℂ) * z))
        = δ⁻¹ • ∫ x in (0:ℝ)..δ, Complex.exp ((x:ℂ) * z) := by
      have := intervalIntegral.integral_comp_mul_left
        (a := 0) (b := 1) (c := δ) (f := fun u : ℝ => Complex.exp ((u:ℂ) * z)) hδ
      simp only [mul_zero, mul_one] at this
      rw [← this]
      apply intervalIntegral.integral_congr
      intro x hx
      simp [Complex.ofReal_mul]
      ring_nf
    rw [hc, Complex.real_smul, ← mul_assoc]
    push_cast
    rw [mul_inv_cancel₀ (by exact_mod_cast hδ), one_mul]
