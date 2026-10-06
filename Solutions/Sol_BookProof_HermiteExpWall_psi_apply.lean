-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.psi_apply
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (x : ℝ) : psi N x = x ^ N * gaussH x := by

  simp [psi, gaussPoly]
