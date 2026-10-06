-- Generated from ChapterFiniteBayesHierarchy.lean — solution of BookProof.ChapterFiniteBayesHierarchy.collapseKernels_append
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
open BookProof.ChapterFiniteBayesHierarchy



open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition

variable {S : Type*} [Fintype S] [DecidableEq S]

variable {S : Type*} [Fintype S] [DecidableEq S]

set_option maxHeartbeats 1000000 in
theorem solution (ks₁ ks₂ : List (S → S → ℝ)) :
    collapseKernels (ks₁ ++ ks₂) =
      compKernel (collapseKernels ks₁) (collapseKernels ks₂) := by

  induction ks₁ with
  | nil => simp [idKernel_comp]
  | cons k ks₁ ih => 
    simp [ih, compKernel_assoc]
