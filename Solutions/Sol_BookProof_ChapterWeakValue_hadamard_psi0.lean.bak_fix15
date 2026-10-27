-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.hadamard_psi0
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : (H *ᵥ psi0) = ![(1 / Real.sqrt 2 : ℂ), (1 / Real.sqrt 2 : ℂ)] := by

  funext b
  fin_cases b <;>
    simp [H, psi0, Matrix.mulVec, dotProduct, Fin.sum_univ_two]
