-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteFactor_zero
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

_i)` in the `i`-th coordinate. -/
def hermiteFactor (i : Fin d) (n : ℕ) : MvPolynomial (Fin d) ℂ :=
  Polynomial.aeval (X i : MvPolynomial (Fi := by sorry
