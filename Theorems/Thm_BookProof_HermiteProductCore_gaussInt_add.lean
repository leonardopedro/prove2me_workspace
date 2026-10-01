-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_add
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

sInt_add (r s : MvPolynomial (Fin d) ℂ) :
    gaussInt (r + s) = gaussInt r + gaussInt s := by
  rw [ga := by sorry
