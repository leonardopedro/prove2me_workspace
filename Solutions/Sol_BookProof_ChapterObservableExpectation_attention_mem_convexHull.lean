-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.attention_mem_convexHull
import Mathlib
import Definitions.Def_ChapterObservableExpectation
import Theorems.Thm_BookProof_ChapterObservableExpectation_prob_weighted_sum_mem_convexHull
open BookProof.ChapterObservableExpectation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (j₀ : Fin m) :
    attentionOutput q k v ∈ convexHull ℝ (Set.range v) :=
  prob_weighted_sum_mem_convexHull _ (fun j => bornWeight_nonneg q k j)
      (bornWeight_sum_one q k j₀) v
