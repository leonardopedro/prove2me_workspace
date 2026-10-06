-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.gaussInt_zero'
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : gaussInt (0 : MvPolynomial (Fin d) ℂ) = 0 := by

  simp [gaussInt]
