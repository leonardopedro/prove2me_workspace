-- Generated from ChapterDeterministic.lean — solution of BookProof.ChapterDeterministic.measOp_mul_proj_apply
import Mathlib
import Definitions.Def_ChapterDeterministic
import Theorems.Thm_BookProof_ChapterTimeTranslation_measOp_apply
open BookProof.ChapterDeterministic



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) (a b i j : Fin n) :
    (measOp U b * proj a) i j =
      if j = a then U i b * (starRingEnd ℂ) (U a b) else 0 := by

  rw [Matrix.mul_apply];
  rw [ Finset.sum_eq_single a ] <;> simp +contextual [ proj, measOp_apply ]
