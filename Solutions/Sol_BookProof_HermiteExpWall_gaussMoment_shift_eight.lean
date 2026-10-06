-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gaussMoment_shift_eight
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_step
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) : gaussMoment (2 * N + 8)
    = ((2 * (N:ℝ)) + 7) * ((2 * (N:ℝ)) + 5) * ((2 * (N:ℝ)) + 3) * ((2 * (N:ℝ)) + 1)
        * gaussMoment (2 * N) := by

  have h1 : gaussMoment (2 * N + 8) = ((2 * N + 6 : ℕ) + 1 : ℝ) * gaussMoment (2 * N + 6) := by
    simpa using gaussMoment_step (2 * N + 6)
  have h2 : gaussMoment (2 * N + 6) = ((2 * N + 4 : ℕ) + 1 : ℝ) * gaussMoment (2 * N + 4) := by
    simpa using gaussMoment_step (2 * N + 4)
  have h3 : gaussMoment (2 * N + 4) = ((2 * N + 2 : ℕ) + 1 : ℝ) * gaussMoment (2 * N + 2) := by
    simpa using gaussMoment_step (2 * N + 2)
  have h4 : gaussMoment (2 * N + 2) = ((2 * N : ℕ) + 1 : ℝ) * gaussMoment (2 * N) := by
    simpa using gaussMoment_step (2 * N)
  rw [h1, h2, h3, h4]
  push_cast
  ring
