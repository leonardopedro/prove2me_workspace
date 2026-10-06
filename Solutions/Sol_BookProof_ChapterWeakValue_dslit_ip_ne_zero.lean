-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.dslit_ip_ne_zero
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_hadamard_psi0
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}
private theorem sqrt2_ne_zero : ((1 : ℂ) / (Real.sqrt 2 : ℂ)) ≠ 0 := by
  have h : (Real.sqrt 2 : ℝ) ≠ 0 := by positivity
  simp [Complex.ofReal_ne_zero.mpr h]

set_option maxHeartbeats 1000000 in
theorem solution : ip psi0 (H *ᵥ psi0) ≠ 0 := by

  have : ip psi0 (H *ᵥ psi0) = (1 / Real.sqrt 2 : ℂ) := by
    rw [hadamard_psi0]
    simp [ip, psi0, Fin.sum_univ_two]
  rw [this]
  exact sqrt2_ne_zero
