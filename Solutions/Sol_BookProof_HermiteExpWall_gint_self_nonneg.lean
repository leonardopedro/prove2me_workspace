-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gint_self_nonneg
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_integral_gaussPoly_sq
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (q : Polynomial ℝ) : 0 ≤ gint (q * q) :=
    rw [← integral_gaussPoly_sq]
    exact integral_nonneg fun x => sq_nonneg _
  
  theo
