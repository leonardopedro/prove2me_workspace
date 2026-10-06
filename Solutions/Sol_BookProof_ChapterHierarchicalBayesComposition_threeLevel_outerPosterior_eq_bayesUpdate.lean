-- Generated from ChapterHierarchicalBayesComposition.lean — solution of BookProof.ChapterHierarchicalBayesComposition.threeLevel_outerPosterior_eq_bayesUpdate
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
import Theorems.Thm_BookProof_ChapterHierarchicalBayes_outerPosterior_eq_bayesUpdate
open BookProof.ChapterHierarchicalBayesComposition



open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ)
    (k₁ : A → B → ℝ) (k₂ : B → C → ℝ) (likelihood : C → ℝ) :
    BookProof.ChapterHierarchicalBayes.outerPosterior outer
        (compKernel k₁ k₂) (fun _ c => likelihood c) =
      BookProof.ChapterSequentialBayes.bayesUpdate outer
        (BookProof.ChapterHierarchicalBayes.marginalLikelihood
          (compKernel k₁ k₂) (fun _ c => likelihood c)) := by

  exact BookProof.ChapterHierarchicalBayes.outerPosterior_eq_bayesUpdate
    outer (compKernel k₁ k₂) (fun _ c => likelihood c)
