-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_pos
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Theorems.Thm_BookProof_ChapterCoherentThermalFidelity_coherentThermalFidelity_eq
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) (lam : ℝ) :
    0 < coherentThermalFidelity nbar lam := by

  have hpos : (0 : ℝ) < nbar + 1 := by linarith
  rw [coherentThermalFidelity_eq h]
  positivity
