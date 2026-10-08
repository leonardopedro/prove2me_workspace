-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.idKernel_nonnegative
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition


open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


theorem BookProof.ChapterHierarchicalBayesComposition.idKernel_nonnegative : IsNonnegativeKernel (idKernel : A → A → ℝ) := by sorry
