-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.gaussPolyDeriv_two_monomial
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.gaussPolyDeriv_two_monomial (m : ℕ) :
    gaussPolyDeriv (gaussPolyDeriv ((Polynomial.X : Polynomial ℝ) ^ (m + 2)))
      = - kinQ m (aCoef m) (bCoef m) := by sorry
