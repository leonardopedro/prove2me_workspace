-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.chargeQ_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Theorems.Thm_BookProof_ChapterGaugeMechanicsCharge_chargeQ_homogeneous
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution : chargeQ ≠ 0 := by

  intro h
  have h1 : chargeQ (1 : P) = 0 := by rw [h]; rfl
  have h2 : chargeQ (1 : P) = (-Complex.I * (((0 : ℕ) : ℂ) + 2)) • (1 : P) :=
    chargeQ_homogeneous (isHomogeneous_one _ _)
  rw [h1] at h2
  have hne : (-Complex.I * (((0 : ℕ) : ℂ) + 2)) ≠ 0 := by
    norm_num [Complex.I_ne_zero]
  rcases smul_eq_zero.mp h2.symm with hz | hz
  · exact hne hz
  · exact one_ne_zero hz
