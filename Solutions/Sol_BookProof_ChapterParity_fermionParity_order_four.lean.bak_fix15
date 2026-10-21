-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.fermionParity_order_four
import Mathlib
import Definitions.Def_ChapterParity
import Theorems.Thm_BookProof_ChapterParity_mgamma0_sq
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    mgamma 0 * mgamma 0 ≠ 1 ∧
      mgamma 0 * mgamma 0 * (mgamma 0 * mgamma 0) = 1 := by

  refine ⟨?_, ?_⟩
  · rw [mgamma0_sq]
    intro h
    have := congrArg (fun M => M 0 0) h
    norm_num [Matrix.one_apply] at this
  · rw [mgamma0_sq]; simp
