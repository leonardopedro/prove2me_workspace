-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.aCoef_nonneg
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) : 0 ≤ aCoef m :=
    unfold aCoef; positivity
  
  theo
