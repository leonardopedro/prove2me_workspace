-- Generated from ChapterHierarchicalBayes.lean — theorem BookProof.ChapterHierarchicalBayes.outerPosterior_eq_bayesUpdate
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes
open BookProof.ChapterHierarchicalBayes


open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]


theorem BookProof.ChapterHierarchicalBayes.outerPosterior_eq_bayesUpdate (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) :
    outerPosterior outer inner likelihood =
      BookProof.ChapterSequentialBayes.bayesUpdate outer
        (marginalLikelihood inner likelihood) := by sorry
