-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.operatorBasis_card
import Mathlib
import Definitions.Def_ChapterF8
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) : Fintype.card (Fin m × Fin m) = m * m := by

  simp
