-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.observableExpectation_add_left
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
theorem solution (p q : Fin m → ℝ) (v : Fin m → E) :
    observableExpectation (fun j => p j + q j) v
      = observableExpectation p v + observableExpectation q v := by

  simp [observableExpectation, add_smul, Finset.sum_add_distrib]
