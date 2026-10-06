-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.gaussInt_leibniz'
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.gaussInt_leibniz_prime (i : Fin d) (P Q : MvPolynomial (Fin d) ℂ) :
    gaussInt (pderiv i P * Q) + gaussInt (P * pderiv i Q) = gaussInt (X i * (P * Q)) := by sorry
