-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.gaussInt_creation
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Theorems.Thm_BookProof_GaussCoordCombo_gaussInt_leibniz'
import Theorems.Thm_BookProof_GaussCoordCombo_gaussInt_sub'
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    gaussInt ((X i * p - pderiv i p) * q) = gaussInt (p * pderiv i q) := by

  have hleib := gaussInt_leibniz' i p q
  have h1 : (X i * p - pderiv i p) * q = X i * (p * q) - pderiv i p * q := by ring
  rw [h1, gaussInt_sub']
  linear_combination -hleib
