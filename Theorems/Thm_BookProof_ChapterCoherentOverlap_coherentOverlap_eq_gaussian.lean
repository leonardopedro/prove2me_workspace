-- Generated from ChapterCoherentOverlap.lean — theorem BookProof.ChapterCoherentOverlap.coherentOverlap_eq_gaussian
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap


open scoped BigOperators

noncomputable section


variable {n : ℕ}


theorem BookProof.ChapterCoherentOverlap.coherentOverlap_eq_gaussian (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = Real.exp (-‖q - k‖ ^ 2 / 2) := by sorry
