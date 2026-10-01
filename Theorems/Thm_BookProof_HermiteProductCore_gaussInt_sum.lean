-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_sum
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

un x => ?_)
  simp [add_mul]

theorem BookProof.HermiteProductCore.gaussInt_sum (c : ℂ) (r : MvPolynomial (Fin d) ℂ) :
    gaussInt (c • r) = c * gaussInt r := by
  rw [gauss := by sorry
