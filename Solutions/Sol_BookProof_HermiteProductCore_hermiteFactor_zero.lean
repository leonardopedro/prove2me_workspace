-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteFactor_zero
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteCx_zero
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
_i)` in the `i`-th coordinate. -/
def hermiteFactor (i : Fin d) (n : ℕ) : MvPolynomial (Fin d) ℂ :=
  Polynomial.aeval (X i : MvPolynomial (Fi :=
  n d) ℂ) (hermiteCx n)
  
  theorem hermiteFactor_zero (i : Fin d) : hermiteFactor i 0 = 1 := by
    simp [hermiteFactor, hermiteCx_zero]
  
  theorem hermite
