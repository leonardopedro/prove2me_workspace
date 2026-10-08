-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.gaussInt_creation
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo



open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.GaussCoordCombo.gaussInt_creation (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    gaussInt ((X i * p - pderiv i p) * q) = gaussInt (p * pderiv i q) := by sorry
