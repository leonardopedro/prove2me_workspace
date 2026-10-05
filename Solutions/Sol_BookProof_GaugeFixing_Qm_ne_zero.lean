-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.Qm_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : Qm ≠ 0 := by

  intro h
  have h01 : Qm 0 1 = (0 : Mat2) 0 1 := by rw [h]
  simp [Qm] at h01
