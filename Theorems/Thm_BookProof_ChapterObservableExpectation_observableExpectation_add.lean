-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.observableExpectation_add
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterObservableExpectation.observableExpectation_add (p : Fin m → ℝ) (v w : Fin m → E) :
    observableExpectation p (fun j => v j + w j)
      = observableExpectation p v + observableExpectation p w := by sorry
