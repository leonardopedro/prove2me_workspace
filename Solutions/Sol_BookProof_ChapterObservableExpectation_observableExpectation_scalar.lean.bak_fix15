-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.observableExpectation_scalar
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
theorem solution (p v : Fin m → ℝ) :
    observableExpectation p v = ∑ j, p j * v j := by

  simp [observableExpectation, smul_eq_mul]
