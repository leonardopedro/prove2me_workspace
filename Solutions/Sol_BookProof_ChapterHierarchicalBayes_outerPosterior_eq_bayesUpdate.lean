-- Generated from ChapterHierarchicalBayes.lean — solution of BookProof.ChapterHierarchicalBayes.outerPosterior_eq_bayesUpdate
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
import Theorems.Thm_BookProof_ChapterHierarchicalBayes_evidence_eq_marginal
open BookProof.ChapterHierarchicalBayes



open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]

variable {A B : Type*} [Fintype A] [Fintype B]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) :
    outerPosterior outer inner likelihood =
      BookProof.ChapterSequentialBayes.bayesUpdate outer
        (marginalLikelihood inner likelihood) := by

  funext a
  unfold outerPosterior BookProof.ChapterSequentialBayes.bayesUpdate
  rw [evidence_eq_marginal]
