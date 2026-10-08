-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.bayesPosterior_sum_one
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterObservableExpectation


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

variable {Y : Type*}

theorem BookProof.ChapterObservableExpectation.bayesPosterior_sum_one {prior : Fin m → ℝ} {L : Fin m → Y → ℝ} (y : Y)
    (hy : 0 < evidence prior L y) : ∑ x, posterior prior L y x = 1 := by sorry
