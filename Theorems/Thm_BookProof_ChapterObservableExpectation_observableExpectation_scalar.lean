-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.observableExpectation_scalar
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


theorem BookProof.ChapterObservableExpectation.observableExpectation_scalar (p v : Fin m → ℝ) :
    observableExpectation p v = ∑ j, p j * v j := by sorry
