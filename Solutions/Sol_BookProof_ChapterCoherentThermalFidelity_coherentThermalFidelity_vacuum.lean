-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_vacuum
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
theorem solution (lam : ℝ) :
    coherentThermalFidelity 0 lam = Real.exp (-lam) := by

  rw [coherentThermalFidelity_eq le_rfl]
  norm_num
