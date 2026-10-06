-- Generated from ChapterBoseEinstein.lean — solution of BookProof.ChapterBoseEinstein.exp_sub_one_pos
import Mathlib
import Definitions.Def_ChapterBoseEinstein
open BookProof.ChapterBoseEinstein



noncomputable section

open Filter Topology


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation

variable {x : ℝ}

variable {x : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hx : 0 < x) : 0 < Real.exp x - 1 := by

  have := Real.add_one_lt_exp (ne_of_gt hx)
  linarith
