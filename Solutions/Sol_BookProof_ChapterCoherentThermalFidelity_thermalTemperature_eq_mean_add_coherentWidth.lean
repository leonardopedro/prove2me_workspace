-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.thermalTemperature_eq_mean_add_coherentWidth
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
    thermalTemperature nbar = nbar + coherentWidth := by

  rw [thermalTemperature, coherentWidth]
