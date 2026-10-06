-- Generated from ChapterFiniteBayesHierarchy.lean — theorem BookProof.ChapterFiniteBayesHierarchy.collapseKernels_nonnegative
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition
open BookProof.ChapterFiniteBayesHierarchy

variable {S : Type*} [Fintype S] [DecidableEq S]


open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition


theorem BookProof.ChapterFiniteBayesHierarchy.collapseKernels_nonnegative (ks : List (S → S → ℝ))
    (hks : ∀ k ∈ ks, IsNonnegativeKernel k) :
    IsNonnegativeKernel (collapseKernels ks) := by sorry
