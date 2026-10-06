-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_nonnegative
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


open scoped BigOperators



theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_nonnegative (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (h₁ : IsNonnegativeKernel k₁) (h₂ : IsNonnegativeKernel k₂) :
    IsNonnegativeKernel (compKernel k₁ k₂) := by sorry
