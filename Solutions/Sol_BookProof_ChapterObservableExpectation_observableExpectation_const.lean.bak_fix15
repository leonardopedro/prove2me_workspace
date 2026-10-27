-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.observableExpectation_const
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
theorem solution (p : Fin m → ℝ) (hp : ∑ j, p j = 1) (c : E) :
    observableExpectation p (fun _ => c) = c := by

  rw [observableExpectation, ← Finset.sum_smul, hp, one_smul]
