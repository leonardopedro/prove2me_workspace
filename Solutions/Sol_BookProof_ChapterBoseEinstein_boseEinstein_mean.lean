-- Generated from ChapterBoseEinstein.lean — solution of BookProof.ChapterBoseEinstein.boseEinstein_mean
import Mathlib
import Definitions.Def_ChapterBoseEinstein
import Theorems.Thm_BookProof_ChapterBoseEinstein_boseEinstein_pos
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_mean
open BookProof.ChapterBoseEinstein



noncomputable section

open Filter Topology


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation

variable {x : ℝ}

variable {x : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hx : 0 < x) :
    ∑' n : ℕ, (n : ℝ) * thermalProb (boseEinstein x) n = boseEinstein x := thermalProb_mean (le_of_lt (boseEinstein_pos hx))
