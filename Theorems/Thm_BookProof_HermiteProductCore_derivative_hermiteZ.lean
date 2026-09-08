-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.derivative_hermiteZ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.derivative_hermiteZ (n : ℕ) :
    Polynomial.derivative (Polynomial.hermite (n + 1))
      = Polynomial.C ((n : ℤ) + 1) * Polynomial.hermite n := by sorry
