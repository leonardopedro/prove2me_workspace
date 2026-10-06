-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.higgsParity_order_four
import Mathlib
import Definitions.Def_ChapterParity
import Theorems.Thm_BookProof_ChapterParity_higgsParity_sq
import Theorems.Thm_BookProof_ChapterParity_higgsParity_pow_four
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    higgsParity * higgsParity ≠ 1 ∧
      higgsParity * higgsParity * (higgsParity * higgsParity) = 1 := by

  refine ⟨?_, higgsParity_pow_four⟩
  rw [higgsParity_sq]
  intro h
  have := congrArg (fun M => M 0 0) h
  norm_num [Matrix.one_apply] at this
