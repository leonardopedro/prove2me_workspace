-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.mul_commutes_chargeQ_iff_euler_zero
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Theorems.Thm_BookProof_ChapterGaugeMechanicsCharge_chargeQ_comm_mul
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution (g : P) :
    (∀ p : P, chargeQ (g * p) = g * chargeQ p) ↔ eulerOp g = 0 := by

  constructor
  · intro h
    have h1 := chargeQ_comm_mul g 1
    rw [h 1, sub_self, mul_one] at h1
    rcases smul_eq_zero.mp h1.symm with hz | hz
    · exact absurd hz (by simp [Complex.I_ne_zero])
    · exact hz
  · intro hg p
    have h1 := chargeQ_comm_mul g p
    rw [hg, zero_mul, smul_zero] at h1
    exact sub_eq_zero.mp h1
