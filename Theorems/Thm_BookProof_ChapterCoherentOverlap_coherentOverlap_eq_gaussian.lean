-- Generated from ChapterCoherentOverlap.lean — theorem BookProof.ChapterCoherentOverlap.coherentOverlap_eq_gaussian
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap

variable {n : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlap.coherentOverlap_eq_gaussian (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = Real.exp (-‖q - k‖ ^ 2 / 2) := by sorry
