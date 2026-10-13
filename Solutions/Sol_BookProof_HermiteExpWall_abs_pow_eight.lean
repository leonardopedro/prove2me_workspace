-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.abs_pow_eight
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : |t| ^ 8 = t ^ 8 := by

  rw [show (8 : ℕ) = 2 * 4 from rfl, pow_mul, pow_mul, sq_abs]
