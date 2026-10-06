-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.neg_deriv2_psi
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterQgHermiteCore
open BookProof.GhostField
open BookProof.HermiteCore
open BookProof.QgHermiteCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.neg_deriv2_psi (m : ℕ) :
    (fun x => -deriv (deriv (psi (m + 2))) x) = gaussPoly (kinQ m (aCoef m) (bCoef m)) := by sorry
