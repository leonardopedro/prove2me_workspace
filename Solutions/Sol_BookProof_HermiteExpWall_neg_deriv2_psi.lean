-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.neg_deriv2_psi
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussPolyDeriv_two_monomial
import Theorems.Thm_BookProof_QgHermiteCore_deriv2_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterQgHermiteCore
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore
open BookProof.GhostField
open BookProof.HermiteCore
open BookProof.QgHermiteCore

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution (m : ℕ) :
    (fun x => -deriv (deriv (psi (m + 2))) x) = gaussPoly (kinQ m (aCoef m) (bCoef m)) := by
  funext x
  simp only [BookProof.HermiteExpWall.psi, deriv2_gaussPoly, gaussPolyDeriv_two_monomial, gaussPoly, Polynomial.eval_neg]
  ring
