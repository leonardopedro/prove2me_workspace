-- Generated from ChapterPriorDependence.lean — theorem BookProof.ChapterPriorDependence.diracPrior_sum_one
import Mathlib
import Definitions.Def_ChapterPriorDependence
open BookProof.ChapterPriorDependence

variable {Hyp Data : Type*} [DecidableEq Hyp]
variable [Fintype Hyp]


open scoped BigOperators



theorem BookProof.ChapterPriorDependence.diracPrior_sum_one (a : Hyp) : ∑ x, diracPrior a x = 1 := by sorry
