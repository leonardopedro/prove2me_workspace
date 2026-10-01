-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.brst_charge_nilpotent
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {R : Type*} [Ring R] (b f : R)
    (hf : f * f = 0) (hbf : Commute b f) : (b * f) * (b * f) = 0 := by

  have h : b * f * (b * f) = b * b * (f * f) := by
    rw [mul_assoc, ← mul_assoc f b f, ← hbf.eq, mul_assoc, mul_assoc]
  rw [h, hf, mul_zero]
