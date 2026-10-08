-- Generated from ChapterBoseEinstein.lean — theorem BookProof.ChapterBoseEinstein.boseEinstein_mean
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


theorem BookProof.ChapterBoseEinstein.boseEinstein_mean (hx : 0 < x) :
    ∑' n : ℕ, (n : ℝ) * thermalProb (boseEinstein x) n = boseEinstein x := by sorry
