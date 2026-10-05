-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.s_gaugeField
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Theorems.Thm_BookProof_GaugeFixing_s_d_phi
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : S.s (gaugeField S) = S.c := by

  have e1 : S.s (gaugeField S) = S.sub (1, 1) (S.s S.v) (S.s (S.d S.phi)) :=
    S.s_sub 1 0 S.v (S.d S.phi)
  rw [e1, s_d_phi, S.sub_zero, S.def_s_v]
