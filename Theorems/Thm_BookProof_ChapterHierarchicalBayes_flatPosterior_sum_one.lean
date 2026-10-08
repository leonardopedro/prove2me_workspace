-- Generated from ChapterHierarchicalBayes.lean — theorem BookProof.ChapterHierarchicalBayes.flatPosterior_sum_one
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes


open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]


theorem BookProof.ChapterHierarchicalBayes.flatPosterior_sum_one (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ)
    (hEvidence : 0 < hierEvidence outer inner likelihood) :
    ∑ a, ∑ b, flatPosterior outer inner likelihood a b = 1 := by sorry
