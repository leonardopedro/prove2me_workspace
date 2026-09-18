-- Generated from ChapterH6.lean — solution of BookProof.ChapterH6.reduce_generator_mul_m
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6



noncomputable section

open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) : Fintype.card (Fin m × Fin m) = m * m := by

  simp
