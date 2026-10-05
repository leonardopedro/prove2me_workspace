-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.s_c_eq_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : S.s S.c = S.zero (1, 2) := by

  have h := S.s_nilpotent 1 0 S.v
  rw [S.def_s_v] at h
  exact h
