-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gaussMoment_step
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteProductCore_gaussMoment_succ
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : gaussMoment (k + 2) = ((k : ℝ) + 1) * gaussMoment k := by

  simpa using gaussMoment_succ (k + 1)
