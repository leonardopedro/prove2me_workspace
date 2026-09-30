-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.lc1_shift
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep











open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}











variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    lc1 (a + Finsupp.single i 1) i = rc1 a i := by

  rw [lc1, rc1]
  norm_num
