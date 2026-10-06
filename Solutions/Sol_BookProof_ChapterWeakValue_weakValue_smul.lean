-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_smul
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_ip_smul_right
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (c • A) = c * weakValue i f A := by

  rw [weakValue, weakValue, Matrix.smul_mulVec, ip_smul_right, mul_div_assoc]
