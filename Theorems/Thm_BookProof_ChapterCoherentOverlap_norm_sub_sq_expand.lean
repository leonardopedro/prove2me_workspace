-- Generated from ChapterCoherentOverlap.lean — theorem BookProof.ChapterCoherentOverlap.norm_sub_sq_expand
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap


open scoped BigOperators

noncomputable section


variable {n : ℕ}


theorem BookProof.ChapterCoherentOverlap.norm_sub_sq_expand (q k : EuclideanSpace ℝ (Fin n)) :
    ‖q - k‖ ^ 2 = ‖q‖ ^ 2 + ‖k‖ ^ 2 - 2 * inner ℝ q k := by sorry
