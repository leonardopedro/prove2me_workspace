-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_eq_temperature_form
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


theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_eq_temperature_form (h : 0 ≤ nbar) (lam : ℝ) :
    coherentThermalFidelity nbar lam
      = Real.exp (-(lam / (thermalTemperature nbar + coherentWidth)))
        / (thermalTemperature nbar + coherentWidth) := by sorry
