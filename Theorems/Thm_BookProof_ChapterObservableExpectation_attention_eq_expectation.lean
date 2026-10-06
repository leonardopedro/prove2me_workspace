-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.attention_eq_expectation
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


theorem BookProof.ChapterObservableExpectation.attention_eq_expectation (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (j₀ : Fin m) :
    (∀ j, 0 ≤ bornWeight q k j) ∧ (∑ j, bornWeight q k j = 1) ∧
      attentionOutput q k v = observableExpectation (bornWeight q k) v := by sorry
