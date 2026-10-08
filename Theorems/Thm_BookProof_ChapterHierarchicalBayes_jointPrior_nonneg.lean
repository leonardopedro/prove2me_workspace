-- Generated from ChapterHierarchicalBayes.lean — theorem BookProof.ChapterHierarchicalBayes.jointPrior_nonneg
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes


open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]


theorem BookProof.ChapterHierarchicalBayes.jointPrior_nonneg (outer : A → ℝ) (inner : A → B → ℝ)
    (hOuter : ∀ a, 0 ≤ outer a) (hInner : ∀ a b, 0 ≤ inner a b) :
    ∀ a b, 0 ≤ jointPrior outer inner a b := by sorry
