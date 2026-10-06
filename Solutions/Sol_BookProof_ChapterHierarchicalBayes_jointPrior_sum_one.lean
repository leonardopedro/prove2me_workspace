-- Generated from ChapterHierarchicalBayes.lean — solution of BookProof.ChapterHierarchicalBayes.jointPrior_sum_one
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes



open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]

variable {A B : Type*} [Fintype A] [Fintype B]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ) (inner : A → B → ℝ)
    (hOuter : ∑ a, outer a = 1) (hInner : ∀ a, ∑ b, inner a b = 1) :
    ∑ a, ∑ b, jointPrior outer inner a b = 1 := by

  simp only [jointPrior]
  rw [show ∑ a, ∑ b, outer a * inner a b = ∑ a, outer a * ∑ b, inner a b by
    congr 1 with a
    rw [← Finset.mul_sum]]
  simp [hInner, hOuter]
