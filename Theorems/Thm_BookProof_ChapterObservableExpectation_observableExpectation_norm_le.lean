-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.observableExpectation_norm_le
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]


theorem BookProof.ChapterObservableExpectation.observableExpectation_norm_le {F : Type*} [NormedAddCommGroup F]
    [NormedSpace ℝ F] (p : Fin m → ℝ) (hp : ∀ j, 0 ≤ p j) (hp1 : ∑ j, p j = 1)
    (v : Fin m → F) (C : ℝ) (hC : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation p v‖ ≤ C := by sorry
