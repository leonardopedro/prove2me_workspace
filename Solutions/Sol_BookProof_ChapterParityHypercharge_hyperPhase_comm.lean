-- Generated from ChapterParityHypercharge.lean — solution of BookProof.ChapterParityHypercharge.hyperPhase_comm
import Mathlib
import Definitions.Def_ChapterParityHypercharge
open BookProof.ChapterParityHypercharge



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) : hyperPhase θ * mgamma5 = mgamma5 * hyperPhase θ := by

  unfold hyperPhase; simp [mul_add, add_mul]
