-- Generated from ChapterHierarchicalBayes.lean — solution of BookProof.ChapterHierarchicalBayes.jointPrior_nonneg
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes



open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]

variable {A B : Type*} [Fintype A] [Fintype B]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ) (inner : A → B → ℝ)
    (hOuter : ∀ a, 0 ≤ outer a) (hInner : ∀ a b, 0 ≤ inner a b) :
    ∀ a b, 0 ≤ jointPrior outer inner a b := by

  intro a b
  rw [jointPrior]
  exact mul_nonneg (hOuter a) (hInner a b)
