-- Generated from ChapterParityZ4.lean — solution of BookProof.ChapterParityZ4.combinedParity_order_four
import Mathlib
import Definitions.Def_ChapterParityZ4
import Theorems.Thm_BookProof_ChapterParityZ4_combinedParity_sq_ne_one
import Theorems.Thm_BookProof_ChapterParityZ4_combinedParity_pow_four
open BookProof.ChapterParityZ4



open Matrix


open BookProof.ChapterParity
open BookProof.ChapterParityQL
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    combinedParity ^ 2 ≠ 1 ∧ combinedParity ^ 4 = 1 := ⟨combinedParity_sq_ne_one, combinedParity_pow_four⟩
