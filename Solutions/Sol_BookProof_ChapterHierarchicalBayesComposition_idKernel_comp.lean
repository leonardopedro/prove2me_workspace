-- Generated from ChapterHierarchicalBayesComposition.lean — solution of BookProof.ChapterHierarchicalBayesComposition.idKernel_comp
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition



open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

set_option maxHeartbeats 1000000 in
theorem solution (k : A → B → ℝ) :
    compKernel (idKernel : A → A → ℝ) k = k := by

  funext a b
  simp [compKernel, idKernel]
