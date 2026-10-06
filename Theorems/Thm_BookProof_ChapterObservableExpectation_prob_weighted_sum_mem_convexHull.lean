-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.prob_weighted_sum_mem_convexHull
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterObservableExpectation.prob_weighted_sum_mem_convexHull (p : Fin m → ℝ) (hp : ∀ j, 0 ≤ p j)
    (hp1 : ∑ j, p j = 1) (v : Fin m → E) :
    observableExpectation p v ∈ convexHull ℝ (Set.range v) := by sorry
