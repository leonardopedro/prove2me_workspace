-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.sirk_error_bound_antitone
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    Antitone (fun m : ℕ => sirkBound C Dmin h nv m) := by

  intro a b hab
  have hexp : Real.exp (-(h * (b : ℝ))) ≤ Real.exp (-(h * (a : ℝ))) := by
    apply Real.exp_le_exp.mpr
    have : (a : ℝ) ≤ (b : ℝ) := Nat.cast_le.mpr hab
    nlinarith
  have h2C : 0 ≤ 2 * C := by linarith
  exact mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hexp h2C) hD) hnv
