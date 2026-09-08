-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteZ_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.hermiteZ_X_mul (n : ℕ) :
    (Polynomial.X : Polynomial ℤ) * Polynomial.hermite n
      = Polynomial.hermite (n + 1) + (n : ℤ) • Polynomial.hermite (n - 1) := by sorry
