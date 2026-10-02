-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteCx_X_mul
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.hermiteCx_X_mul (n : ℕ) :
    (Polynomial.X : Polynomial ℂ) * hermiteCx n
      = hermiteCx (n + 1) + (n : ℂ) • hermiteCx (n - 1) := by sorry
