-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.online_cost_independent_of_M
import Mathlib
import Definitions.Def_ChapterF8
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M M' d m K₂ k : ℕ) :
    totalCost M d m K₂ k + offlineCost M' d k
      = totalCost M' d m K₂ k + offlineCost M d k := by

  rw [totalCost, totalCost]
  omega
