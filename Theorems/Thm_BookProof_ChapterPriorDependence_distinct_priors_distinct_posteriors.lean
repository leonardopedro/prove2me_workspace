-- Generated from ChapterPriorDependence.lean — theorem BookProof.ChapterPriorDependence.distinct_priors_distinct_posteriors
import Mathlib
import Definitions.Def_ChapterPriorDependence
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterPriorDependence


open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable [Fintype Hyp]

theorem BookProof.ChapterPriorDependence.distinct_priors_distinct_posteriors (a b : Hyp) (hab : a ≠ b)
    (L : Hyp → Data → ℝ) (d : Data) (ha : 0 < L a d) :
    BookProof.ChapterBayesInference.posterior (diracPrior a) L d ≠
      BookProof.ChapterBayesInference.posterior (diracPrior b) L d := by sorry
