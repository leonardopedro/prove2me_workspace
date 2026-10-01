-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.derivative_hermiteR
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteR_zero
import Theorems.Thm_BookProof_HermiteCore_hermiteR_one
import Theorems.Thm_BookProof_HermiteCore_hermiteR_succ
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    derivative (hermiteR (n + 1)) = C ((n : ℝ) + 1) * hermiteR n := by

  induction n with
  | zero => simp [hermiteR_one, hermiteR_zero]
  | succ n ih =>
    have key : derivative (hermiteR (n + 1 + 1))
        = hermiteR (n + 1) + C ((n : ℝ) + 1) * (X * hermiteR n - derivative (hermiteR n)) := by
      rw [hermiteR_succ (n + 1), derivative_sub, derivative_mul, derivative_X, ih,
        derivative_C_mul]
      ring
    have hC : (C (((n : ℝ) + 1) + 1) : Polynomial ℝ) = C ((n : ℝ) + 1) + 1 := by
      rw [map_add, map_one]
    rw [key, ← hermiteR_succ n]
    push_cast
    rw [hC]
    ring
