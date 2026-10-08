-- Generated from ChapterHierarchicalBayes.lean — theorem BookProof.ChapterHierarchicalBayes.evidence_eq_marginal
import Mathlib
import Definitions.Def_ChapterHierarchicalBayes
open BookProof.ChapterHierarchicalBayes


open scoped BigOperators


variable {A B : Type*} [Fintype A] [Fintype B]


theorem BookProof.ChapterHierarchicalBayes.evidence_eq_marginal (outer : A → ℝ) (inner : A → B → ℝ)
    (likelihood : A → B → ℝ) :
    hierEvidence outer inner likelihood =
      ∑ a, outer a * marginalLikelihood inner likelihood a := by sorry
