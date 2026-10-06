-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.ip_projMat
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_projMat_mulVec
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin n) (f v : Fin n → ℂ) :
    ip f (projMat a *ᵥ v) = starRingEnd ℂ (f a) * v a := by

  simp [ip, projMat_mulVec, Finset.sum_ite_eq']
