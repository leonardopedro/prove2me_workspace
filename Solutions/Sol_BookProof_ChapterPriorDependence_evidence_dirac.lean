-- Generated from ChapterPriorDependence.lean — solution of BookProof.ChapterPriorDependence.evidence_dirac
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

theorem solution (a : Hyp) (L : Hyp → Data → ℝ) (d : Data) :
    BookProof.ChapterBayesInference.evidence (diracPrior a) L d = L a d := by
  unfold ChapterBayesInference.evidence
  simp [diracPrior]

/-
Positive-likelihood Bayesian updating preserves a deterministic prior.
-/
