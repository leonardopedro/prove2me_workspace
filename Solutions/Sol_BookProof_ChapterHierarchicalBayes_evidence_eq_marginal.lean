-- Generated from ChapterHierarchicalBayes.lean — solution of BookProof.ChapterHierarchicalBayes.evidence_eq_marginal
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes



open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]

variable {A B : Type*} [Fintype A] [Fintype B]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) :
    hierEvidence outer inner likelihood =
      ∑ a, outer a * marginalLikelihood inner likelihood a := by

  unfold hierEvidence marginalLikelihood jointPrior
  apply Finset.sum_congr rfl
  intro a ha
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro b hb
  ring
