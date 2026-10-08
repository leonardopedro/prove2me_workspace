-- Generated from ChapterPriorDependence.lean — theorem BookProof.ChapterPriorDependence.diracPrior_sum_one
import Mathlib
import Definitions.Def_ChapterPriorDependence
open BookProof.ChapterPriorDependence


open scoped BigOperators


variable {Hyp Data : Type*} [DecidableEq Hyp]

variable [Fintype Hyp]

theorem BookProof.ChapterPriorDependence.diracPrior_sum_one (a : Hyp) : ∑ x, diracPrior a x = 1 := by sorry
