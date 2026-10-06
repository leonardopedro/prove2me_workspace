-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.attention_mem_convexHull
import Mathlib
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterObservableExpectation

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterObservableExpectation.attention_mem_convexHull (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (j₀ : Fin m) :
    attentionOutput q k v ∈ convexHull ℝ (Set.range v) := by sorry
