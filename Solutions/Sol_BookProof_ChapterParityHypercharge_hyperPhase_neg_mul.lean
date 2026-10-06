-- Generated from ChapterParityHypercharge.lean — solution of BookProof.ChapterParityHypercharge.hyperPhase_neg_mul
import Mathlib
import Definitions.Def_ChapterParityHypercharge
import Theorems.Thm_BookProof_ChapterParityHypercharge_hyperPhase_zero
import Theorems.Thm_BookProof_ChapterParityHypercharge_hyperPhase_add
open BookProof.ChapterParityHypercharge



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) : hyperPhase θ * hyperPhase (-θ) = 1 := by

  rw [hyperPhase_add, add_neg_cancel, hyperPhase_zero]
