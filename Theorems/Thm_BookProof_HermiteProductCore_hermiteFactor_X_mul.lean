-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteFactor_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.hermiteFactor_X_mul (i : Fin d) (n : ℕ) :
    X i * hermiteFactor i n = hermiteFactor i (n + 1) + (n : ℂ) • hermiteFactor i (n - 1) := by sorry
