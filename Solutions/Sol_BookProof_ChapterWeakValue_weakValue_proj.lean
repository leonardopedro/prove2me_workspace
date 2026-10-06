-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_proj
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_ip_projMat
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i f : Fin n → ℂ) (a : Fin n) :
    weakValue i f (projMat a) = starRingEnd ℂ (f a) * i a / ip f i := by

  rw [weakValue, ip_projMat]
