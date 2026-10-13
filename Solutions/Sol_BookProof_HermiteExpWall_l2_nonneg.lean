-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.l2_nonneg
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
theorem solution (f : ℝ → ℝ) : 0 ≤ l2 f := Real.sqrt_nonneg _
