-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.osc_psi
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_psi_apply
import Theorems.Thm_BookProof_HermiteExpWall_neg_deriv2_psi
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) :
    (fun x => -deriv (deriv (psi (m + 2))) x + x ^ 2 / 4 * psi (m + 2) x)
      = gaussPoly (oscQ m (aCoef m) (bCoef m)) :=
    funext x
    have h := congrFun (neg_deriv2_psi m) x
    rw [h, psi_apply]
    simp only [kinQ, gaussPoly, Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_C,
      Polynomial.eval_pow, Polynomial.eval_X]
    ring
  
  theorem oscQ_sq (m :
