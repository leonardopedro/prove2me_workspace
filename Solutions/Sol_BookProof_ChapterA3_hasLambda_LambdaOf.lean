-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.hasLambda_LambdaOf
import Mathlib
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∃ Λ, HasLambda S Λ) : HasLambda S (LambdaOf S) := by

  have : LambdaOf S = h.choose := by rw [LambdaOf, dif_pos h]
  rw [this]; exact h.choose_spec
