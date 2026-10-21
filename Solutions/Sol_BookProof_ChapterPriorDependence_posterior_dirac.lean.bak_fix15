-- Generated from ChapterPriorDependence.lean — solution of BookProof.ChapterPriorDependence.posterior_dirac
import Mathlib
import Definitions.Def_ChapterPriorDependence
open BookProof.ChapterPriorDependence



open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable {Hyp Data : Type*} [DecidableEq Hyp]
variable [Fintype Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (a : Hyp) (L : Hyp → Data → ℝ) (d : Data)
    (ha : 0 < L a d) (x : Hyp) :
    BookProof.ChapterBayesInference.posterior (diracPrior a) L d x =
      diracPrior a x := by

  unfold ChapterBayesInference.posterior diracPrior
  split_ifs <;> simp_all [ChapterBayesInference.evidence]
  linarith
