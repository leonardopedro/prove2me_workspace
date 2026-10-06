-- Generated from ChapterBoseEinstein.lean — theorem BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein_eq_coth
import Definitions.Def_ChapterCoherentOccupation
import Mathlib
import Definitions.Def_ChapterBoseEinstein
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterBoseEinstein

variable {x : ℝ}


noncomputable section

open Filter Topology


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation


theorem BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein_eq_coth (hx : 0 < x) :
    thermalTemperature (boseEinstein x) = Real.cosh (x / 2) / (2 * Real.sinh (x / 2)) := by sorry
