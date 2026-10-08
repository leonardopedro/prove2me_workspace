-- Generated from ChapterThermalMaxEntropy.lean — theorem BookProof.ChapterThermalMaxEntropy.gibbs_pointwise
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalMaxEntropy


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}


theorem BookProof.ChapterThermalMaxEntropy.gibbs_pointwise (h : 0 < nbar) {p : ℝ} (hp : 0 ≤ p) (n : ℕ) :
    p * Real.log (thermalProb nbar n) - p * Real.log p ≤ thermalProb nbar n - p := by sorry
