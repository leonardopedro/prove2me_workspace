-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.matrixModelIntegral_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ X : Mat2, matrixModelIntegral.int X ≠ 0 := by

  refine ⟨Pm, ?_⟩
  simp [matrixModelIntegral, Pm]
