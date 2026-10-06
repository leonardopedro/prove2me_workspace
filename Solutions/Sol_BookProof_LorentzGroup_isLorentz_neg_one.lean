-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.isLorentz_neg_one
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsLorentz (-1 : Matrix (Fin 4) (Fin 4) ℝ) := by

  -- By definition of IsLorentz, we need to show that (-1)ᵀ * eta * (-1) = eta.
  simp [IsLorentz]
