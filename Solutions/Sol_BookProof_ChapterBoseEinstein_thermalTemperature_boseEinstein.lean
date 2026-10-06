-- Generated from ChapterBoseEinstein.lean — solution of BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein
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
theorem solution (hx : 0 < x) :
    thermalTemperature (boseEinstein x) = (Real.exp x + 1) / (2 * (Real.exp x - 1)) := by

  have h := exp_sub_one_pos hx
  rw [thermalTemperature, boseEinstein]
  field_simp
  ring
