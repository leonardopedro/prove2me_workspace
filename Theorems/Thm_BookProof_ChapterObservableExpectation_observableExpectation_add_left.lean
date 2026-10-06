-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.observableExpectation_add_left
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterObservableExpectation.observableExpectation_add_left (p q : Fin m → ℝ) (v : Fin m → E) :
    observableExpectation (fun j => p j + q j) v
      = observableExpectation p v + observableExpectation q v := by sorry
