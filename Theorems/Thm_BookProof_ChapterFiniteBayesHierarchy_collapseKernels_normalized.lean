-- Generated from ChapterFiniteBayesHierarchy.lean — theorem BookProof.ChapterFiniteBayesHierarchy.collapseKernels_normalized
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition
open BookProof.ChapterFiniteBayesHierarchy


open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition

variable {S : Type*} [Fintype S] [DecidableEq S]


theorem BookProof.ChapterFiniteBayesHierarchy.collapseKernels_normalized (ks : List (S → S → ℝ))
    (hks : ∀ k ∈ ks, IsNormalizedKernel k) :
    IsNormalizedKernel (collapseKernels ks) := by sorry
