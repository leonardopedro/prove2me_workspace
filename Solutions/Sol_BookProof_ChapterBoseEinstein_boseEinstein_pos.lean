-- Generated from ChapterBoseEinstein.lean — solution of BookProof.ChapterBoseEinstein.boseEinstein_pos
import Mathlib
import Definitions.Def_ChapterBoseEinstein
import Theorems.Thm_BookProof_ChapterBoseEinstein_exp_sub_one_pos
open BookProof.ChapterBoseEinstein



noncomputable section

open Filter Topology


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation

variable {x : ℝ}

variable {x : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hx : 0 < x) : 0 < boseEinstein x := div_pos one_pos (exp_sub_one_pos hx)
