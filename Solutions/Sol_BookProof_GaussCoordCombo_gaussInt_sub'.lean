-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.gaussInt_sub'
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_add
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_smul
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r s : MvPolynomial (Fin d) ℂ) :
    gaussInt (r - s) = gaussInt r - gaussInt s := by

  have h := gaussInt_add r (-s)
  rw [show (-s) = (-1 : ℂ) • s by module, gaussInt_smul] at h
  rw [show r - s = r + (-1 : ℂ) • s by module, h]
  ring
