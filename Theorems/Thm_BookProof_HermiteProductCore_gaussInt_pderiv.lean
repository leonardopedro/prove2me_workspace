-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_pderiv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.gaussInt_pderiv (j : Fin d) (r : MvPolynomial (Fin d) ℂ) :
    gaussInt (pderiv j r) = gaussInt (X j * r) := by sorry
