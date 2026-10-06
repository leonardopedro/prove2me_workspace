-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.integral_gaussPoly_sq
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterQgHermiteCore
open BookProof.HermiteCore
open BookProof.QgHermiteCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.integral_gaussPoly_sq (q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly q x ^ 2 = gint (q * q) := by sorry
