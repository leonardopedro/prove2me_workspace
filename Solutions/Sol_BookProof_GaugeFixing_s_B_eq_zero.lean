-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.s_B_eq_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : S.s S.B = S.zero (1, 1) := by

  have h := S.s_nilpotent 1 (-1) S.c_bar
  rw [S.def_s_c_bar] at h
  exact h
