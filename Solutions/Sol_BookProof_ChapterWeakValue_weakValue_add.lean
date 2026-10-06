-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_add
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_ip_add_right
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i f : Fin n → ℂ) (A B : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (A + B) = weakValue i f A + weakValue i f B := by

  rw [weakValue, weakValue, weakValue, Matrix.add_mulVec, ip_add_right, add_div]
