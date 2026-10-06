-- Generated from ChapterPriorDependence.lean — solution of BookProof.ChapterPriorDependence.diracPrior_nonneg
import Mathlib
import Definitions.Def_ChapterPriorDependence
open BookProof.ChapterPriorDependence



open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable {Hyp Data : Type*} [DecidableEq Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (a x : Hyp) : 0 ≤ diracPrior a x := by

  unfold diracPrior
  split_ifs <;> norm_num
