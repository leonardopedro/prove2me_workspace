-- Generated from ChapterObservableOperator.lean — theorem BookProof.ChapterObservableOperator.expectation_outerProj
import Mathlib
import Definitions.Def_ChapterObservableOperator
open BookProof.ChapterObservableOperator


open scoped BigOperators

noncomputable section


variable {n m : ℕ}


theorem BookProof.ChapterObservableOperator.expectation_outerProj (k q : EuclideanSpace ℂ (Fin n)) :
    expectation (outerProj k) q = ((‖(inner ℂ k q : ℂ)‖ ^ 2 : ℝ) : ℂ) := by sorry
