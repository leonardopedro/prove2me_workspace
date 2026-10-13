-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gint_self_nonneg
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_integral_gaussPoly_sq
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterQgHermiteCore
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore
open BookProof.HermiteCore
open BookProof.QgHermiteCore

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution (q : Polynomial ℝ) : 0 ≤ gint (q * q) := by
  rw [← integral_gaussPoly_sq]
  exact integral_nonneg fun x => sq_nonneg _
