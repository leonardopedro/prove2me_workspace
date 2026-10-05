-- Generated from ChapterCoherentGeometry.lean — theorem BookProof.ChapterCoherentGeometry.bornWeight_le_iff_dist_le
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Definitions.Def_ChapterCoherentOverlap
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterCoherentOverlap
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterCoherentGeometry

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterCoherentGeometry.bornWeight_le_iff_dist_le (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m) :
    bornWeight q k i ≤ bornWeight q k j ↔ ‖q - k j‖ ≤ ‖q - k i‖ := by sorry
