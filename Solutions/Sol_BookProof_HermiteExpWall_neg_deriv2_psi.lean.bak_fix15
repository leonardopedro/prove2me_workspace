-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.neg_deriv2_psi
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussPolyDeriv_two_monomial
import Theorems.Thm_BookProof_QgHermiteCore_deriv2_gaussPoly
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) :
    (fun x => -deriv (deriv (psi (m + 2))) x) = gaussPoly (kinQ m (aCoef m) (bCoef m)) :=
    funext x
    simp only [psi, deriv2_gaussPoly, gaussPolyDeriv_two_monomial, gaussPoly, Polynomial.eval_neg]
    ring
  
  /--
