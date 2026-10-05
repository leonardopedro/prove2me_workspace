-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.diagGen_vacuum
import Mathlib
import Definitions.Def_ChapterF3
import Theorems.Thm_BookProof_ChapterF1_numberOp_monomial
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (a : ℂ) : (a • ChapterF1.numberOp) (1 : ℂ[X]) = 0 := by

  convert congr_arg ( fun x : ℂ[X] => a • x ) ( ChapterF1.numberOp_monomial 0 ) using 1
    <;> (first | norm_num | simp)
