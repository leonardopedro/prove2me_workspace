-- Generated from ChapterObservableOperator.lean — solution of BookProof.ChapterObservableOperator.observableOp_expectation_mem_convexHull
import Mathlib
import Definitions.Def_ChapterObservableOperator
import Theorems.Thm_BookProof_ChapterObservableOperator_bornProb_nonneg
import Theorems.Thm_BookProof_ChapterObservableOperator_bornProb_sum_one
import Theorems.Thm_BookProof_ChapterObservableExpectation_prob_weighted_sum_mem_convexHull
open BookProof.ChapterObservableOperator



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution
    (b : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin n))) (v : Fin m → ℝ)
    (q : EuclideanSpace ℂ (Fin n)) (hq : ‖q‖ = 1) :
    BookProof.ChapterObservableExpectation.observableExpectation
        (bornProb (fun j => b j) q) v ∈ convexHull ℝ (Set.range v) :=
  BookProof.ChapterObservableExpectation.prob_weighted_sum_mem_convexHull _
      (fun j => bornProb_nonneg _ q j) (bornProb_sum_one b q hq) v
