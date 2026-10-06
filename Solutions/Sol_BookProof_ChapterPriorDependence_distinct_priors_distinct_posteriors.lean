-- Generated from ChapterPriorDependence.lean — solution of BookProof.ChapterPriorDependence.distinct_priors_distinct_posteriors
import Mathlib
import Definitions.Def_ChapterPriorDependence
import Theorems.Thm_BookProof_ChapterPriorDependence_posterior_dirac
open BookProof.ChapterPriorDependence



open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable {Hyp Data : Type*} [DecidableEq Hyp]
variable [Fintype Hyp]

set_option maxHeartbeats 1000000 in
theorem solution (a b : Hyp) (hab : a ≠ b)
    (L : Hyp → Data → ℝ) (d : Data) (ha : 0 < L a d) :
    BookProof.ChapterBayesInference.posterior (diracPrior a) L d ≠
      BookProof.ChapterBayesInference.posterior (diracPrior b) L d := by

  intro h
  have heq := congrFun h a
  rw [posterior_dirac a L d ha a] at heq
  simp [diracPrior, hab, BookProof.ChapterBayesInference.posterior] at heq
