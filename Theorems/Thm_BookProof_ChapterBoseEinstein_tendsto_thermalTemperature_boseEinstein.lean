-- Generated from ChapterBoseEinstein.lean — theorem BookProof.ChapterBoseEinstein.tendsto_thermalTemperature_boseEinstein
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


theorem BookProof.ChapterBoseEinstein.tendsto_thermalTemperature_boseEinstein :
    Tendsto (fun x : ℝ => thermalTemperature (boseEinstein x)) atTop (𝓝 (1 / 2)) := by sorry
