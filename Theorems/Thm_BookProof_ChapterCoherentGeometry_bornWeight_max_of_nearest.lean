-- Generated from ChapterCoherentGeometry.lean — theorem BookProof.ChapterCoherentGeometry.bornWeight_max_of_nearest
import Definitions.Def_ChapterCoherentOverlap
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterCoherentGeometry

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterCoherentGeometry.bornWeight_max_of_nearest (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m)
    (hj : ∀ l, ‖q - k j‖ ≤ ‖q - k l‖) (i : Fin m) :
    bornWeight q k i ≤ bornWeight q k j := by sorry
