-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_vacuum
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
open BookProof.ChapterCoherentThermalFidelity

variable {nbar lam : ℝ}


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real


theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_vacuum (lam : ℝ) :
    coherentThermalFidelity 0 lam = Real.exp (-lam) := by sorry
