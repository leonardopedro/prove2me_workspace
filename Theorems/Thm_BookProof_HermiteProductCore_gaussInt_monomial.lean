-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_monomial
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.gaussInt_monomial (a : Fin d →₀ ℕ) :
    gaussInt (monomial a (1 : ℂ)) = ∏ i, ((gaussMoment (a i) : ℝ) : ℂ) := by sorry
