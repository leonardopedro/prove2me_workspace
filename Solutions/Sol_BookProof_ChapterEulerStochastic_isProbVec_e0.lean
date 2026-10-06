-- Generated from ChapterEulerStochastic.lean — solution of BookProof.ChapterEulerStochastic.isProbVec_e0
import Mathlib
import Definitions.Def_ChapterEulerStochastic
open BookProof.ChapterEulerStochastic



open scoped Matrix BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : IsProbVec ![1, 0] := by

  exact ⟨ fun i => by fin_cases i <;> norm_num, by norm_num ⟩
