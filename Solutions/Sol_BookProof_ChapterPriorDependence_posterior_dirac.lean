-- Generated from ChapterPriorDependence.lean — solution of BookProof.ChapterPriorDependence.posterior_dirac
import Mathlib
import Definitions.Def_ChapterPriorDependence
import Definitions.Def_ChapterBayesInference
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterPriorDependence



open scoped BigOperators
open BookProof.ChapterBayesInference
open BookProof.ChapterDeepLearningSampling


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

/-
Two distinct deterministic prior assumptions yield distinct posteriors for
the same data whenever the first supported hypothesis has positive likelihood.
-/
