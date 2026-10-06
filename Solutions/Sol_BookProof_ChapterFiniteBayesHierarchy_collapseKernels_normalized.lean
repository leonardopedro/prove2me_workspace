-- Generated from ChapterFiniteBayesHierarchy.lean — solution of BookProof.ChapterFiniteBayesHierarchy.collapseKernels_normalized
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
open BookProof.ChapterFiniteBayesHierarchy



open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition

variable {S : Type*} [Fintype S] [DecidableEq S]

variable {S : Type*} [Fintype S] [DecidableEq S]

set_option maxHeartbeats 1000000 in
theorem solution (ks : List (S → S → ℝ))
    (hks : ∀ k ∈ ks, IsNormalizedKernel k) :
    IsNormalizedKernel (collapseKernels ks) := by

  induction ks with
  | nil => exact idKernel_normalized
  | cons k ks ih => 
    simp only [collapseKernels]
    exact compKernel_normalized k (collapseKernels ks) (hks k (by simp)) (ih fun k hk => hks k
                                                                  (by simp only [List.mem_cons];
                                                                      exact Or.inr hk))
