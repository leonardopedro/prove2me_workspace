-- Generated from ChapterThermalMaxEntropy.lean — theorem BookProof.ChapterThermalMaxEntropy.thermalEntropy_boseEinstein
import Definitions.Def_ChapterCoherentOccupation
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
import Definitions.Def_ChapterBoseEinstein
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterBoseEinstein
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalMaxEntropy


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}


theorem BookProof.ChapterThermalMaxEntropy.thermalEntropy_boseEinstein {x : ℝ} (hx : 0 < x) :
    thermalEntropy (boseEinstein x)
      = -Real.log (1 - Real.exp (-x)) + x * boseEinstein x := by sorry
