-- Generated from ChapterBoseEinstein.lean — theorem BookProof.ChapterBoseEinstein.thermalRatio_boseEinstein
import Definitions.Def_ChapterCoherentOccupation
import Mathlib
import Definitions.Def_ChapterBoseEinstein
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterBoseEinstein


noncomputable section

open Filter Topology


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation

variable {x : ℝ}


theorem BookProof.ChapterBoseEinstein.thermalRatio_boseEinstein (hx : 0 < x) :
    thermalRatio (boseEinstein x) = Real.exp (-x) := by sorry
