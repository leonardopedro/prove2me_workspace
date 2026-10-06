-- Generated from ChapterPriorDependence.lean — theorem BookProof.ChapterPriorDependence.evidence_dirac
import Mathlib
import Definitions.Def_ChapterPriorDependence
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterPriorDependence

variable {Hyp Data : Type*} [DecidableEq Hyp]
variable [Fintype Hyp]


open scoped BigOperators



theorem BookProof.ChapterPriorDependence.evidence_dirac (a : Hyp) (L : Hyp → Data → ℝ) (d : Data) :
    BookProof.ChapterBayesInference.evidence (diracPrior a) L d = L a d := by sorry
