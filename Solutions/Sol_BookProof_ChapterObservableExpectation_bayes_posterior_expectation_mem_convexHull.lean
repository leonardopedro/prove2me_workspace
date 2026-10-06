-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.bayes_posterior_expectation_mem_convexHull
import Mathlib
import Definitions.Def_ChapterObservableExpectation
import Theorems.Thm_BookProof_ChapterObservableExpectation_prob_weighted_sum_mem_convexHull
import Theorems.Thm_BookProof_ChapterObservableExpectation_bayesPosterior_nonneg
import Theorems.Thm_BookProof_ChapterObservableExpectation_bayesPosterior_sum_one
open BookProof.ChapterObservableExpectation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]
variable {Y : Type*}

set_option maxHeartbeats 1000000 in
theorem solution
    (prior : Fin m → ℝ) (L : Fin m → Y → ℝ) (y : Y)
    (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (hy : 0 < evidence prior L y) (v : Fin m → E) :
    observableExpectation (posterior prior L y) v ∈ convexHull ℝ (Set.range v) :=
  prob_weighted_sum_mem_convexHull _
      (fun x => bayesPosterior_nonneg hprior hL y x) (bayesPosterior_sum_one y hy) v
