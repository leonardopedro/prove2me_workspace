-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gint_X_pow
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore
open BookProof.HermiteCore

noncomputable section

set_option maxHeartbeats 1000000 in


theorem solution (k : ℕ) : gint ((Polynomial.X : Polynomial ℝ) ^ k) = gaussMoment k := by rfl
