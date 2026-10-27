-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.observableExpectation_add
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
theorem solution (p : Fin m → ℝ) (v w : Fin m → E) :
    observableExpectation p (fun j => v j + w j)
      = observableExpectation p v + observableExpectation p w := by

  simp [observableExpectation, smul_add, Finset.sum_add_distrib]
