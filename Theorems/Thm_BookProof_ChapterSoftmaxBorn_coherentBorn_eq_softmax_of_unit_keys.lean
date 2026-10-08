-- Generated from ChapterSoftmaxBorn.lean — theorem BookProof.ChapterSoftmaxBorn.coherentBorn_eq_softmax_of_unit_keys
import Definitions.Def_ChapterCoherentOverlap
import Mathlib
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap

variable {n m : ℕ}


theorem BookProof.ChapterSoftmaxBorn.coherentBorn_eq_softmax_of_unit_keys (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (hk : ∀ l, ‖k l‖ = 1) (j : Fin m) :
    bornWeight q k j = softmax 2 q k j := by sorry
