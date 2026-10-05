-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.totalCost_sub_offline
import Mathlib
import Definitions.Def_ChapterF8
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M d m K₂ k : ℕ) :
    totalCost M d m K₂ k - offlineCost M d k = onlineCost d m K₂ k := by

  rw [totalCost]
  omega
