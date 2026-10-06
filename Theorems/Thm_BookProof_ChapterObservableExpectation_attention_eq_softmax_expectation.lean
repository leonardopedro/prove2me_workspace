-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.attention_eq_softmax_expectation
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


theorem BookProof.ChapterObservableExpectation.attention_eq_softmax_expectation (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r)
    (v : Fin m → E) :
    attentionOutput q k v = observableExpectation (softmax 2 q k) v := by sorry
