-- Generated from ChapterPriorDependence.lean — solution of BookProof.ChapterPriorDependence.diracPrior_sum_one
import Mathlib
import Definitions.Def_ChapterPriorDependence
open BookProof.ChapterPriorDependence



open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable {Hyp Data : Type*} [DecidableEq Hyp]
variable [Fintype Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (a : Hyp) : ∑ x, diracPrior a x = 1 := by

  unfold diracPrior
  aesop
