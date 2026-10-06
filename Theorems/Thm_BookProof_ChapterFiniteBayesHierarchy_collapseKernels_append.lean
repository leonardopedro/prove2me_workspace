-- Generated from ChapterFiniteBayesHierarchy.lean — theorem BookProof.ChapterFiniteBayesHierarchy.collapseKernels_append
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition
open BookProof.ChapterFiniteBayesHierarchy

variable {S : Type*} [Fintype S] [DecidableEq S]


open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition


theorem BookProof.ChapterFiniteBayesHierarchy.collapseKernels_append (ks₁ ks₂ : List (S → S → ℝ)) :
    collapseKernels (ks₁ ++ ks₂) =
      compKernel (collapseKernels ks₁) (collapseKernels ks₂) := by sorry
