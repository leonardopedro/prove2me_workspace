-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.observableExpectation_smul
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


theorem BookProof.ChapterObservableExpectation.observableExpectation_smul (p : Fin m → ℝ) (c : ℝ) (v : Fin m → E) :
    observableExpectation p (fun j => c • v j) = c • observableExpectation p v := by sorry
