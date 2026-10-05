-- Generated from ChapterCoherentGeometry.lean — theorem BookProof.ChapterCoherentGeometry.coherentOverlap_le_iff_dist_le
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap
open BookProof.ChapterCoherentGeometry

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterCoherentGeometry.coherentOverlap_le_iff_dist_le (q k k' : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k ≤ coherentOverlap q k' ↔ ‖q - k'‖ ≤ ‖q - k‖ := by sorry
