-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gaussMoment_even_mono
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_step
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_even_pos
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (h : m ≤ n) :
    gaussMoment (2 * m) ≤ gaussMoment (2 * n) := by

  induction n with
  | zero => simp_all
  | succ n ih =>
      rcases Nat.lt_or_ge m (n + 1) with hlt | hge
      · have hpos := gaussMoment_even_pos n
        have hstep : gaussMoment (2 * n) ≤ gaussMoment (2 * (n + 1)) := by
          rw [show 2 * (n + 1) = 2 * n + 2 by ring, gaussMoment_step]
          nlinarith [hpos, Nat.cast_nonneg (α := ℝ) (2 * n)]
        exact le_trans (ih (Nat.lt_succ_iff.mp hlt)) hstep
      · rw [le_antisymm h hge]
