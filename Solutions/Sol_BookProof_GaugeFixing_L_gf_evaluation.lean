-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.L_gf_evaluation
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Theorems.Thm_BookProof_GaugeFixing_s_gaugeField
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution :
    S.s (Psi S) =
      S.sub (2, 0) (S.mul (1, 0) (1, 0) S.B (gaugeField S))
        (S.mul (1, -1) (1, 1) S.c_bar S.c) := by

  have h := S.s_mul_c_bar (gaugeField S)
  rw [s_gaugeField] at h
  exact h
