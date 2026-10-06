-- Generated from ChapterHierarchicalBayesComposition.lean — solution of BookProof.ChapterHierarchicalBayesComposition.compKernel_assoc
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
theorem solution (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (k₃ : C → D → ℝ) :
    compKernel (compKernel k₁ k₂) k₃ = compKernel k₁ (compKernel k₂ k₃) := by

  funext a d
  unfold compKernel
  simp_rw [Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro c hc
  apply Finset.sum_congr rfl
  intro b hb
  ring
