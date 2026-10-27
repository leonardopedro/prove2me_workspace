-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.gaussPolyDeriv_monomial
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) :
    gaussPolyDeriv ((Polynomial.X : Polynomial ℝ) ^ (m + 2))
      = Polynomial.C ((m : ℝ) + 2) * Polynomial.X ^ (m + 1)
        - Polynomial.C (1 / 2 : ℝ) * Polynomial.X ^ (m + 3) :=
    unfold gaussPolyDeriv
    rw [Polynomial.derivative_X_pow]
    push_cast
    ring
  
  theo
