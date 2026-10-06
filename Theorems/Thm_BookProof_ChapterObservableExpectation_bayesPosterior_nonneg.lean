-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.bayesPosterior_nonneg
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterObservableExpectation

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]
variable {Y : Type*}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterObservableExpectation.bayesPosterior_nonneg {prior : Fin m → ℝ} {L : Fin m → Y → ℝ}
    (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y) (y : Y) (x : Fin m) :
    0 ≤ posterior prior L y x := by sorry
