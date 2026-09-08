-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteMv_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.hermiteMv_X_mul (i : Fin d) (a : Fin d →₀ ℕ) :
    X i * hermiteMv a
      = hermiteMv (a + Finsupp.single i 1) + ((a i : ℂ)) • hermiteMv (a - Finsupp.single i 1) := by sorry
