-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.Pm_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : Pm ≠ 0 := by

  intro h
  have h10 : Pm 1 0 = (0 : Mat2) 1 0 := by rw [h]
  simp [Pm] at h10
