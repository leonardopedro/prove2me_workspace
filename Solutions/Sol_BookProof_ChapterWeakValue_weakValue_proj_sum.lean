-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_proj_sum
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_weakValue_proj
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i f : Fin n → ℂ) (h : ip f i ≠ 0) :
    ∑ a, weakValue i f (projMat a) = 1 := by

  simp only [weakValue_proj, ← Finset.sum_div]
  rw [show ∑ a, starRingEnd ℂ (f a) * i a = ip f i from rfl, div_self h]
