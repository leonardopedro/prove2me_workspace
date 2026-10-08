-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_normalized
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition


open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_normalized (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (h₁ : IsNormalizedKernel k₁) (h₂ : IsNormalizedKernel k₂) :
    IsNormalizedKernel (compKernel k₁ k₂) := by sorry
