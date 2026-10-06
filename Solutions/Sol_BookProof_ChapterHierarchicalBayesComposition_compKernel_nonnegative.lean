-- Generated from ChapterHierarchicalBayesComposition.lean — solution of BookProof.ChapterHierarchicalBayesComposition.compKernel_nonnegative
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition



open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

set_option maxHeartbeats 1000000 in
theorem solution (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (h₁ : IsNonnegativeKernel k₁) (h₂ : IsNonnegativeKernel k₂) :
    IsNonnegativeKernel (compKernel k₁ k₂) := by

  intro a c
  exact Finset.sum_nonneg fun b _ => mul_nonneg (h₁ a b) (h₂ b c)
