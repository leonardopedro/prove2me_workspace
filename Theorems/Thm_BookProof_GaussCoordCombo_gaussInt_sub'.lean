-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.gaussInt_sub'
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo



open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.GaussCoordCombo.gaussInt_sub_prime (r s : MvPolynomial (Fin d) ℂ) :
    gaussInt (r - s) = gaussInt r - gaussInt s := by sorry
