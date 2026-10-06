-- Generated from ChapterBoseEinstein.lean — solution of BookProof.ChapterBoseEinstein.boseEinstein_strictAntiOn
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
theorem solution : StrictAntiOn boseEinstein (Set.Ioi 0) := by

  intro a ha b _ hab
  have ha' : 0 < a := ha
  have h1 := exp_sub_one_pos ha'
  have hexp : Real.exp a < Real.exp b := Real.exp_lt_exp.mpr hab
  rw [boseEinstein, boseEinstein]
  apply one_div_lt_one_div_of_lt h1
  linarith
