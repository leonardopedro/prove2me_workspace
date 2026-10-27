-- Generated from ChapterSoftmaxBorn.lean — solution of BookProof.ChapterSoftmaxBorn.coherentBorn_sq_eq
import Mathlib
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumer q k =
      Real.exp (-‖q‖ ^ 2) * Real.exp (-‖k‖ ^ 2) * Real.exp (2 * inner ℝ q k) := by

  rw [bornNumer, coherentOverlap, ← Real.exp_nat_mul, ← Real.exp_add, ← Real.exp_add]
  congr 1
  ring
