-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.gaussInt_leibniz'
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_add
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_pderiv
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (P Q : MvPolynomial (Fin d) ℂ) :
    gaussInt (pderiv i P * Q) + gaussInt (P * pderiv i Q) = gaussInt (X i * (P * Q)) := by

  rw [← gaussInt_pderiv i (P * Q), ← gaussInt_add]
  congr 1
  rw [Derivation.leibniz]
  simp only [smul_eq_mul]
  ring
