-- Generated from ChapterPriorDependence.lean — theorem BookProof.ChapterPriorDependence.posterior_dirac
import Mathlib
import Definitions.Def_ChapterPriorDependence
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterPriorDependence


open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable [Fintype Hyp]

theorem BookProof.ChapterPriorDependence.posterior_dirac (a : Hyp) (L : Hyp → Data → ℝ) (d : Data)
    (ha : 0 < L a d) (x : Hyp) :
    BookProof.ChapterBayesInference.posterior (diracPrior a) L d x =
      diracPrior a x := by sorry
