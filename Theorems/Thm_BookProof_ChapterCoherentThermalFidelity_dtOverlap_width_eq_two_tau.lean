-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.dtOverlap_width_eq_two_tau
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterA4
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentThermalFidelity

variable {nbar lam : ℝ}


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real


theorem BookProof.ChapterCoherentThermalFidelity.dtOverlap_width_eq_two_tau (nb : NNReal) :
    ((nb : ℝ) + 1 / 2) + ((nb : ℝ) + 1 / 2)
      = thermalTemperature (nb : ℝ) + thermalTemperature (nb : ℝ) := by sorry
