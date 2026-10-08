-- Generated from ChapterCoherentGeometry.lean — theorem BookProof.ChapterCoherentGeometry.neg_two_mul_log_coherentOverlap
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap
open BookProof.ChapterCoherentGeometry


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}


theorem BookProof.ChapterCoherentGeometry.neg_two_mul_log_coherentOverlap (q k : EuclideanSpace ℝ (Fin n)) :
    -2 * Real.log (coherentOverlap q k) = ‖q - k‖ ^ 2 := by sorry
