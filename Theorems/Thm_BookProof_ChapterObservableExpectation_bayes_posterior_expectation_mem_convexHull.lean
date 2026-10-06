-- Generated from ChapterObservableExpectation.lean — theorem BookProof.ChapterObservableExpectation.bayes_posterior_expectation_mem_convexHull
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


theorem BookProof.ChapterObservableExpectation.bayes_posterior_expectation_mem_convexHull
    (prior : Fin m → ℝ) (L : Fin m → Y → ℝ) (y : Y)
    (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (hy : 0 < evidence prior L y) (v : Fin m → E) :
    observableExpectation (posterior prior L y) v ∈ convexHull ℝ (Set.range v) := by sorry
