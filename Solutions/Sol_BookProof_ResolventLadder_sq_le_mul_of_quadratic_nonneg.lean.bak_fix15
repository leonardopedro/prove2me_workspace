-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.sq_le_mul_of_quadratic_nonneg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A B C : ℝ} (hC : 0 ≤ C)
    (h : ∀ t : ℝ, 0 ≤ A + 2 * t * B + t ^ 2 * C) : B ^ 2 ≤ A * C := by

  have hA : 0 ≤ A := by simpa using h 0
  rcases eq_or_lt_of_le hC with hC0 | hCpos
  · -- `C = 0`: then `B = 0`.
    have hB : B = 0 := by
      by_contra hB
      have hlin : ∀ t : ℝ, 0 ≤ A + 2 * t * B := by
        intro t
        have := h t
        rw [← hC0] at this
        simpa using this
      have hval : 2 * (-(A + 1) / (2 * B)) * B = -(A + 1) := by field_simp
      have hkey := hlin (-(A + 1) / (2 * B))
      rw [hval] at hkey
      linarith
    rw [hB, ← hC0]
    simp
  · have hkey := h (-B / C)
    have hexp : A + 2 * (-B / C) * B + (-B / C) ^ 2 * C = A - B ^ 2 / C := by
      field_simp
      ring
    rw [hexp] at hkey
    have hd : B ^ 2 / C ≤ A := by linarith
    calc B ^ 2 = B ^ 2 / C * C := by field_simp
      _ ≤ A * C := mul_le_mul_of_nonneg_right hd hCpos.le
