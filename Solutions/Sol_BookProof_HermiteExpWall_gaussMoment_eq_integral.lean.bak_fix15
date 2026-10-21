-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gaussMoment_eq_integral
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    gaussMoment k = ∫ x : ℝ, x ^ k * gaussW x := by

  simp [gaussMoment, gint]
