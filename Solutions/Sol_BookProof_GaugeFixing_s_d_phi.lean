-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.s_d_phi
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : S.s (S.d S.phi) = S.zero (1, 1) := by

  have h : S.s (S.d S.phi) = S.d (S.s S.phi) := S.sd_commute 0 0 S.phi
  rw [S.def_s_phi] at h
  exact h.trans (S.d_zero 0 1)
