-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.rc2_nonneg
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (i : Fin d) : 0 ≤ rc2 a i := Real.sqrt_nonneg _
