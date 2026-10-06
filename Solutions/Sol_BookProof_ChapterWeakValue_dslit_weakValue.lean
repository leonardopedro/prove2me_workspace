-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.dslit_weakValue
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_weakValue_proj
import Theorems.Thm_BookProof_ChapterWeakValue_hadamard_psi0
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    weakValue (H *ᵥ psi0) psi0 (projMat 0) = 1 ∧
      weakValue (H *ᵥ psi0) psi0 (projMat 1) = 0 := by

  have hip : ip psi0 (H *ᵥ psi0) = (1 / Real.sqrt 2 : ℂ) := by
    rw [hadamard_psi0]; simp [ip, psi0, Fin.sum_univ_two]
  constructor
  · rw [weakValue_proj, hip, hadamard_psi0]
    simp [psi0]
  · rw [weakValue_proj, hip, hadamard_psi0]
    simp [psi0]
