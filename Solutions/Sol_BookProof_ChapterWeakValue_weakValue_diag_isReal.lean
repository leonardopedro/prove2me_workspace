-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_diag_isReal
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_ip_conj_mulVec
import Theorems.Thm_BookProof_ChapterWeakValue_weakValue_diag
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (hA : Aᴴ = A) (hi : ip i i = 1) :
    starRingEnd ℂ (weakValue i i A) = weakValue i i A := by

  rw [weakValue_diag i A hi, ip_conj_mulVec, hA]
