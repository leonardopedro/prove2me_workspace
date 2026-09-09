-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.phi_one
import Mathlib
import Definitions.Def_ChapterH1
import Theorems.Thm_BookProof_ChapterH1_phi_succ_mul
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {z : ℂ} (hz : z ≠ 0) : phi 1 z = (Complex.exp z - 1) / z := by

  have h := phi_succ_mul 0 z
  simp only [phi_zero_apply, Nat.factorial_zero, Nat.cast_one, div_one] at h
  field_simp
  linear_combination h
