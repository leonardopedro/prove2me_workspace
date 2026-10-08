-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.thermalTemperature_eq_mean_add_coherentWidth
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentThermalFidelity


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}


theorem BookProof.ChapterCoherentThermalFidelity.thermalTemperature_eq_mean_add_coherentWidth (nbar : ℝ) :
    thermalTemperature nbar = nbar + coherentWidth := by sorry
