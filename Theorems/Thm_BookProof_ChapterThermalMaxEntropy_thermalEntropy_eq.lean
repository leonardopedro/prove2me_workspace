-- Generated from ChapterThermalMaxEntropy.lean — theorem BookProof.ChapterThermalMaxEntropy.thermalEntropy_eq
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalMaxEntropy

variable {nbar : ℝ}


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein


theorem BookProof.ChapterThermalMaxEntropy.thermalEntropy_eq (h : 0 < nbar) :
    thermalEntropy nbar = Real.log (nbar + 1) - nbar * Real.log (thermalRatio nbar) := by sorry
