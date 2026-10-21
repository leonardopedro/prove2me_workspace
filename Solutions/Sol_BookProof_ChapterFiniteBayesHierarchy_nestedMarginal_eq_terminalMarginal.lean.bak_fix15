-- Generated from ChapterFiniteBayesHierarchy.lean — solution of BookProof.ChapterFiniteBayesHierarchy.nestedMarginal_eq_terminalMarginal
import Mathlib
import Definitions.Def_ChapterFiniteBayesHierarchy
import Theorems.Thm_BookProof_ChapterHierarchicalBayesComposition_terminalMarginal_comp
open BookProof.ChapterFiniteBayesHierarchy



open scoped BigOperators


open BookProof.ChapterHierarchicalBayesComposition

variable {S : Type*} [Fintype S] [DecidableEq S]

variable {S : Type*} [Fintype S] [DecidableEq S]

set_option maxHeartbeats 1000000 in
theorem solution (ks : List (S → S → ℝ))
    (likelihood : S → ℝ) :
    nestedMarginal ks likelihood =
      terminalMarginal (collapseKernels ks) likelihood := by

  induction ks with
  | nil =>
    simp only [nestedMarginal, collapseKernels_nil]
    funext a
    simp [terminalMarginal, idKernel]
  | cons k ks ih =>
    simp only [nestedMarginal, collapseKernels_cons]
    rw [ih]
    exact terminalMarginal_comp k (collapseKernels ks) likelihood
