-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.threeLevel_outerPosterior_eq_bayesUpdate
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
import Definitions.Def_ChapterHierarchicalBayes
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterHierarchicalBayes
open BookProof.ChapterSequentialBayes
open BookProof.ChapterHierarchicalBayesComposition


open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


theorem BookProof.ChapterHierarchicalBayesComposition.threeLevel_outerPosterior_eq_bayesUpdate (outer : A → ℝ)
    (k₁ : A → B → ℝ) (k₂ : B → C → ℝ) (likelihood : C → ℝ) :
    BookProof.ChapterHierarchicalBayes.outerPosterior outer
        (compKernel k₁ k₂) (fun _ c => likelihood c) =
      BookProof.ChapterSequentialBayes.bayesUpdate outer
        (BookProof.ChapterHierarchicalBayes.marginalLikelihood
          (compKernel k₁ k₂) (fun _ c => likelihood c)) := by sorry
