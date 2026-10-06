-- Generated from ChapterCoherentOverlap.lean — theorem BookProof.ChapterCoherentOverlap.norm_sub_sq_expand
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap

variable {n : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlap.norm_sub_sq_expand (q k : EuclideanSpace ℝ (Fin n)) :
    ‖q - k‖ ^ 2 = ‖q‖ ^ 2 + ‖k‖ ^ 2 - 2 * inner ℝ q k := by sorry
