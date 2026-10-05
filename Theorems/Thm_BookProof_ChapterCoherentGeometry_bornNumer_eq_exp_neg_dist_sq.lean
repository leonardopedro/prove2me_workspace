-- Generated from ChapterCoherentGeometry.lean — theorem BookProof.ChapterCoherentGeometry.bornNumer_eq_exp_neg_dist_sq
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


theorem BookProof.ChapterCoherentGeometry.bornNumer_eq_exp_neg_dist_sq (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumer q k = Real.exp (-‖q - k‖ ^ 2) := by sorry
