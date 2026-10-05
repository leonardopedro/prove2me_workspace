-- Generated from ChapterCoherentGeometry.lean — theorem BookProof.ChapterCoherentGeometry.bornWeight_eq_scoreSoftmax_neg_dist_sq
import Definitions.Def_ChapterCoherentOverlap
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterCoherentGeometry

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterCoherentGeometry.bornWeight_eq_scoreSoftmax_neg_dist_sq (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    bornWeight q k j = scoreSoftmax 1 (fun l => -‖q - k l‖ ^ 2) j := by sorry
