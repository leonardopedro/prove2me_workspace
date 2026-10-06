-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_assoc
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


open scoped BigOperators



theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_assoc (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (k₃ : C → D → ℝ) :
    compKernel (compKernel k₁ k₂) k₃ = compKernel k₁ (compKernel k₂ k₃) := by sorry
