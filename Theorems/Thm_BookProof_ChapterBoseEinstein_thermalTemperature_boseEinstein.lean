-- Generated from ChapterBoseEinstein.lean — theorem BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein
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


theorem BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein (hx : 0 < x) :
    thermalTemperature (boseEinstein x) = (Real.exp x + 1) / (2 * (Real.exp x - 1)) := by sorry
