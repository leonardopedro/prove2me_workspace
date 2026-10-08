-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.observableExpectation_const
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


theorem BookProof.ChapterObservableExpectation.observableExpectation_const (p : Fin m → ℝ) (hp : ∑ j, p j = 1) (c : E) :
    observableExpectation p (fun _ => c) = c := by sorry
