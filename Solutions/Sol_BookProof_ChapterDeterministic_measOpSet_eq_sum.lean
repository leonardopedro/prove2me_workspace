-- Generated from ChapterDeterministic.lean — solution of BookProof.ChapterDeterministic.measOpSet_eq_sum
import Mathlib
import Definitions.Def_ChapterDeterministic
open BookProof.ChapterDeterministic



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) (B : Finset (Fin n)) :
    measOpSet U B = ∑ b ∈ B, measOp U b := by

  unfold measOpSet measOp;    simp only [mul_assoc] ;
  unfold projSet; simp [ Finset.sum_mul, Finset.mul_sum ] ;
