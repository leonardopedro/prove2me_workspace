-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.lc2_vanish
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) (h : a i < 2) : lc2 a i = 0 := by

  interval_cases hai : (a i)
  · rw [lc2, hai]; norm_num
  · rw [lc2, hai]; norm_num
