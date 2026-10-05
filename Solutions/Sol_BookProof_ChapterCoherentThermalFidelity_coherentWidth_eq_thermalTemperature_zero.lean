-- Generated from ChapterCoherentThermalFidelity.lean — solution of BookProof.ChapterCoherentThermalFidelity.coherentWidth_eq_thermalTemperature_zero
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
theorem solution :
    coherentWidth = thermalTemperature 0 := by

  rw [coherentWidth, thermalTemperature]; norm_num
