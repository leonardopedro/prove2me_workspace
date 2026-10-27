-- Generated from ChapterParityQL.lean — solution of BookProof.ChapterParityQL.QLParity_order_four
import Mathlib
import Definitions.Def_ChapterParityQL
import Theorems.Thm_BookProof_ChapterParityQL_QLParity_sq
import Theorems.Thm_BookProof_ChapterParityQL_QLParity_pow_four
open BookProof.ChapterParityQL



open Matrix
open scoped Kronecker


open BookProof.ChapterA3
open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution :
    QLParity * QLParity ≠ 1 ∧
      QLParity * QLParity * (QLParity * QLParity) = 1 := by

  refine ⟨?_, QLParity_pow_four⟩
  rw [QLParity_sq]
  intro h
  have := congrArg (fun M => M (0, 0) (0, 0)) h
  norm_num [Matrix.one_apply] at this
