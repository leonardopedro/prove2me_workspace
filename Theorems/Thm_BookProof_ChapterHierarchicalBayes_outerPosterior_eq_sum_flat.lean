-- Generated from ChapterHierarchicalBayes.lean — theorem BookProof.ChapterHierarchicalBayes.outerPosterior_eq_sum_flat
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes

variable {A B : Type*} [Fintype A] [Fintype B]


open scoped BigOperators



theorem BookProof.ChapterHierarchicalBayes.outerPosterior_eq_sum_flat (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) (a : A) :
    outerPosterior outer inner likelihood a =
      ∑ b, flatPosterior outer inner likelihood a b := by sorry
