-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.terminalMarginal_comp
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition


open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


theorem BookProof.ChapterHierarchicalBayesComposition.terminalMarginal_comp (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (likelihood : C → ℝ) :
    terminalMarginal k₁ (terminalMarginal k₂ likelihood) =
      terminalMarginal (compKernel k₁ k₂) likelihood := by sorry
