-- Generated from ChapterHierarchicalBayesComposition.lean — theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_id
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]


open scoped BigOperators



theorem BookProof.ChapterHierarchicalBayesComposition.compKernel_id (k : A → B → ℝ) :
    compKernel k (idKernel : B → B → ℝ) = k := by sorry
