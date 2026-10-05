-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_eq_temperature_form
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Theorems.Thm_BookProof_ChapterCoherentThermalFidelity_coherentThermalFidelity_eq
import Theorems.Thm_BookProof_ChapterCoherentThermalFidelity_coherentThermalFidelity_width_eq
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) (lam : ℝ) :
    coherentThermalFidelity nbar lam
      = Real.exp (-(lam / (thermalTemperature nbar + coherentWidth)))
        / (thermalTemperature nbar + coherentWidth) := by

  rw [coherentThermalFidelity_eq h, ← coherentThermalFidelity_width_eq]
