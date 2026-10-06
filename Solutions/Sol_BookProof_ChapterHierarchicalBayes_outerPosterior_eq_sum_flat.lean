-- Generated from ChapterHierarchicalBayes.lean — solution of BookProof.ChapterHierarchicalBayes.outerPosterior_eq_sum_flat
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes



open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]

variable {A B : Type*} [Fintype A] [Fintype B]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) (a : A) :
    outerPosterior outer inner likelihood a =
      ∑ b, flatPosterior outer inner likelihood a b := by

  unfold outerPosterior flatPosterior marginalLikelihood jointPrior
  rw [Finset.mul_sum, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro b hb
  ring
