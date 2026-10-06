-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.projMat_mulVec
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin n) (v : Fin n → ℂ) (b : Fin n) :
    (projMat a *ᵥ v) b = if b = a then v a else 0 := by

  by_cases hb : b = a <;>
    simp [projMat, Matrix.mulVec, dotProduct, hb, Finset.sum_ite_eq']
