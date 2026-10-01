-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.not_summable_inv_natCast_succ
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : ¬ Summable (fun N : ℕ => ((N : ℝ) + 1)⁻¹) := by

  intro h
  refine Real.not_summable_one_div_natCast ?_
  refine (summable_nat_add_iff 1).mp ?_
  refine h.congr fun N => ?_
  push_cast
  rw [one_div]
