-- Generated from ChapterHierarchicalBayes.lean — solution of BookProof.ChapterHierarchicalBayes.outerPosterior_sum_one
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
import Theorems.Thm_BookProof_ChapterHierarchicalBayes_outerPosterior_eq_sum_flat
import Theorems.Thm_BookProof_ChapterHierarchicalBayes_flatPosterior_sum_one
open BookProof.ChapterHierarchicalBayes



open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]

variable {A B : Type*} [Fintype A] [Fintype B]

set_option maxHeartbeats 1000000 in
theorem solution (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ)
    (hEvidence : 0 < hierEvidence outer inner likelihood) :
    ∑ a, outerPosterior outer inner likelihood a = 1 := by

  rw [show ∑ a, outerPosterior outer inner likelihood a =
      ∑ a, ∑ b, flatPosterior outer inner likelihood a b by
    apply Finset.sum_congr rfl
    intro a ha
    exact outerPosterior_eq_sum_flat outer inner likelihood a]
  exact flatPosterior_sum_one outer inner likelihood hEvidence
