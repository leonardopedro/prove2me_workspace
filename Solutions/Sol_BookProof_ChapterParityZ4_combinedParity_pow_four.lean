-- Generated from ChapterParityZ4.lean — solution of BookProof.ChapterParityZ4.combinedParity_pow_four
import Mathlib
import Definitions.Def_ChapterParityZ4
import Theorems.Thm_BookProof_ChapterParityZ4_combinedParity_sq
open BookProof.ChapterParityZ4



open Matrix


open BookProof.ChapterParity
open BookProof.ChapterParityQL
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : combinedParity ^ 4 = 1 := by

  simp [ pow_succ' ];
  simp [ ← mul_assoc, ← pow_two, combinedParity_sq ]
