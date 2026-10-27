-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.observableExpectation_smul
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
theorem solution (p : Fin m → ℝ) (c : ℝ) (v : Fin m → E) :
    observableExpectation p (fun j => c • v j) = c • observableExpectation p v := by

  rw [observableExpectation, observableExpectation, Finset.smul_sum]
  exact Finset.sum_congr rfl fun j _ => smul_comm (p j) c (v j)
