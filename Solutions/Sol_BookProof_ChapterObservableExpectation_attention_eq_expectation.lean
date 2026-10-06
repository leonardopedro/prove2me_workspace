-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.attention_eq_expectation
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (j₀ : Fin m) :
    (∀ j, 0 ≤ bornWeight q k j) ∧ (∑ j, bornWeight q k j = 1) ∧
      attentionOutput q k v = observableExpectation (bornWeight q k) v := ⟨fun j => bornWeight_nonneg q k j, bornWeight_sum_one q k j₀, rfl⟩
