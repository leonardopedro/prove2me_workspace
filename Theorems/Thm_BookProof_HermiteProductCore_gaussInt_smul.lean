-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_smul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.gaussInt_smul (c : ℂ) (r : MvPolynomial (Fin d) ℂ) :
    gaussInt (c • r) = c * gaussInt r := by sorry
