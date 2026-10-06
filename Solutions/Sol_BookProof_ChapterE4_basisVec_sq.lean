-- Generated from ChapterE4.lean — solution of BookProof.ChapterE4.basisVec_sq
import Mathlib
import Definitions.Def_ChapterE4
open BookProof.ChapterE4



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (k i : ℕ) : (basisVec k i) ^ 2 = if i = k then 1 else 0 := by

  unfold basisVec; aesop;
