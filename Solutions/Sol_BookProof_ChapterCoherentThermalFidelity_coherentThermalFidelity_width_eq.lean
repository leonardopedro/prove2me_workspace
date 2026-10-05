-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_width_eq
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
open BookProof.ChapterCoherentThermalFidelity



noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

variable {nbar lam : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ) :
    nbar + 1 = thermalTemperature nbar + coherentWidth := by

  rw [thermalTemperature, coherentWidth]; ring
