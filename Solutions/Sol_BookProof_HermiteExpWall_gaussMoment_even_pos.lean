-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gaussMoment_even_pos
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_step
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_zero
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : 0 < gaussMoment (2 * n) := by

  induction n with
  | zero =>
      rw [show 2 * 0 = 0 from rfl, gaussMoment_zero]
      exact Real.sqrt_pos.mpr (by positivity)
  | succ n ih =>
      rw [show 2 * (n + 1) = 2 * n + 2 by ring, gaussMoment_step]
      positivity
